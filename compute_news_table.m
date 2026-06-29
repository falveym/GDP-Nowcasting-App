function [news_table, y_old, y_new, impact_revisions] = compute_news_table( ...
        X_old, X_new, Time, Spec, Res, series, period)
%compute_news_table  Reproduces the Nowcast Detail Table from update_nowcast.m
%                    without modifying FRBNY source code.
%
%  Returns the filtered news_table (released series only), plus the scalar
%  nowcast values needed for the Results tab stat cards.

% ── Mirror update_nowcast.m padding logic ────────────────────────────────
N     = size(X_new, 2);
T_old = size(X_old, 1);
T_new = size(X_new, 1);
if T_new > T_old
    X_old = [X_old; NaN(T_new - T_old, N)];
end
X_old = [X_old; NaN(12, N)];
X_new = [X_new; NaN(12, N)];

[y, m, d] = datevec(Time(end));
Time_ext  = [Time; datenum(y, (m+1:m+12)', d)];

% ── Find target series and forecast time ────────────────────────────────
i_series = find(strcmp(series, Spec.SeriesID));

freq = Spec.Frequency{i_series};
switch freq
    case 'q'
        [yr, q_str] = strtok(period, 'q');
        yr  = str2double(yr);
        qtr = str2double(strrep(q_str, 'q', ''));
        mo  = 3 * qtr;
        t_nowcast = find(Time_ext == datenum(yr, mo, 1));
    case 'm'
        [yr, m_str] = strtok(period, 'm');
        yr  = str2double(yr);
        mo  = str2double(strrep(m_str, 'm', ''));
        t_nowcast = find(Time_ext == datenum(yr, mo, 1));
end

if isempty(t_nowcast)
    error('compute_news_table: period is out of nowcasting horizon.');
end

% ── Replicate update_nowcast.m news computation ──────────────────────────
% X_rev: X_new values only where X_old is observed (revision pass)
X_rev = X_new;
X_rev(isnan(X_old)) = NaN;

% Impact from revisions
[y_old] = News_DFM(X_old, X_rev, Res, t_nowcast, i_series);

% Impact from releases
[y_rev, y_new, ~, actual, forecast, weight] = ...
    News_DFM(X_rev, X_new, Res, t_nowcast, i_series);

impact_revisions = y_rev - y_old;

% ── Build news_table (same as update_nowcast.m) ──────────────────────────
if isempty(forecast)
    news_table = table();
    return
end

news           = actual - forecast;
impact_releases = weight .* news;

news_table = array2table([forecast, actual, weight, impact_releases], ...
    'VariableNames', {'Forecast', 'Actual', 'Weight', 'Impact'}, ...
    'RowNames', Spec.SeriesID);

% Filter to released series only (same as update_nowcast.m)
data_released = any(isnan(X_old) & ~isnan(X_new), 1);
news_table    = news_table(data_released, :);

end