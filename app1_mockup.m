classdef app1_mockup < matlab.apps.AppBase

    properties (Access = public)
        UIFigure                matlab.ui.Figure
        TabGroup                matlab.ui.container.TabGroup

        % --- MAIN TAB ---
        MainTab                 matlab.ui.container.Tab
        AppTitleLabel           matlab.ui.control.Label
        FilesPanel              matlab.ui.container.Panel
        FilesPanelLabel         matlab.ui.control.Label
        SpecFileButton          matlab.ui.control.Button
        SpecStatusLabel         matlab.ui.control.Label
        NewVintageButton        matlab.ui.control.Button
        NewVintageStatusLabel   matlab.ui.control.Label
        ConfigPanel             matlab.ui.container.Panel
        ConfigPanelLabel        matlab.ui.control.Label
        TargetVarLabel          matlab.ui.control.Label
        TargetVarDropDown       matlab.ui.control.DropDown
        SeriesFilterLabel       matlab.ui.control.Label
        SeriesFilterNoteLabel   matlab.ui.control.Label
        SeriesListBox           matlab.ui.control.ListBox
        SelectAllButton         matlab.ui.control.Button
        DeselectAllButton       matlab.ui.control.Button
        RunButton               matlab.ui.control.Button
        ExportButton            matlab.ui.control.Button

        % --- RESULTS TAB ---
        ResultsTab              matlab.ui.container.Tab
        NowcastPanel            matlab.ui.container.Panel
        NowcastDateLabel        matlab.ui.control.Label
        NowcastValueLabel       matlab.ui.control.Label
        NowcastUnitsLabel       matlab.ui.control.Label
        PrevVintagePanel        matlab.ui.container.Panel
        PrevVintageTitleLabel   matlab.ui.control.Label
        PrevVintageValueLabel   matlab.ui.control.Label
        PrevVintageDateLabel    matlab.ui.control.Label
        RevisionPanel           matlab.ui.container.Panel
        RevisionTitleLabel      matlab.ui.control.Label
        RevisionValueLabel      matlab.ui.control.Label
        RevisionSubLabel        matlab.ui.control.Label
        ReleasePanel            matlab.ui.container.Panel
        ReleaseTitleLabel       matlab.ui.control.Label
        ReleaseValueLabel       matlab.ui.control.Label
        ReleaseSubLabel         matlab.ui.control.Label
        NewsTableLabel          matlab.ui.control.Label
        NewsUITable             matlab.ui.control.Table
        ExportExcelButton       matlab.ui.control.Button
        ExportLogButton         matlab.ui.control.Button

        % --- AI COPILOT TAB ---
        AICopilotTab            matlab.ui.container.Tab

        % --- FORECAST DETAILS TAB ---
        ForecastDetailsTab      matlab.ui.container.Tab
        ForecastDetailsTitleLabel matlab.ui.control.Label
        ForecastDetailsExportButton matlab.ui.control.Button
        ForecastDetailsTextArea matlab.ui.control.TextArea

        % --- FIGURES TAB GROUP ---
        FiguresTab              matlab.ui.container.Tab
        FiguresTabGroup         matlab.ui.container.TabGroup

        % Fig 1: Raw vs Transformed
        Fig1Tab                 matlab.ui.container.Tab
        Fig1SeriesDropDownLabel matlab.ui.control.Label
        Fig1SeriesDropDown      matlab.ui.control.DropDown
        UIAxes_RawData          matlab.ui.control.UIAxes
        UIAxes_TransformedData  matlab.ui.control.UIAxes

        % Fig 2: Common Factor
        Fig2Tab                 matlab.ui.container.Tab
        UIAxes_CommonFactor     matlab.ui.control.UIAxes

        % Fig 3: Factor Projection
        Fig3Tab                 matlab.ui.container.Tab
        Fig3SeriesDropDownLabel matlab.ui.control.Label
        Fig3SeriesDropDown      matlab.ui.control.DropDown
        Fig3NoteLabel           matlab.ui.control.Label
        UIAxes_Projection       matlab.ui.control.UIAxes
        UIAxes_GDPProjection    matlab.ui.control.UIAxes

        % Spec Comparison
        SpecCompTab             matlab.ui.container.Tab
        UIAxes_NowcastOverlay   matlab.ui.control.UIAxes
        UIAxes_Diff             matlab.ui.control.UIAxes

        % News
        NewsTab                 matlab.ui.container.Tab
        NewsNoteLabel           matlab.ui.control.Label
        UIAxes_News             matlab.ui.control.UIAxes
    end

    methods (Access = private)

        function createComponents(app)

            % Figure
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 780 600];
            app.UIFigure.Name = 'GDP Nowcasting App';
            app.UIFigure.Color = [0.96 0.96 0.96];

            % Outer tab group
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [0 0 780 600];

            % ============================================================
            %  MAIN TAB
            % ============================================================
            app.MainTab = uitab(app.TabGroup);
            app.MainTab.Title = 'Main';

            app.AppTitleLabel = uilabel(app.MainTab);
            app.AppTitleLabel.Text = 'GDP Nowcasting App';
            app.AppTitleLabel.FontSize = 26;
            app.AppTitleLabel.FontWeight = 'bold';
            app.AppTitleLabel.Position = [20 525 500 34];

            % Files panel
            app.FilesPanel = uipanel(app.MainTab);
            app.FilesPanel.Position = [20 400 740 114];
            app.FilesPanel.BackgroundColor = [1 1 1];

            app.FilesPanelLabel = uilabel(app.FilesPanel);
            app.FilesPanelLabel.Text = '1 — Load files';
            app.FilesPanelLabel.FontSize = 11;
            app.FilesPanelLabel.FontWeight = 'bold';
            app.FilesPanelLabel.FontColor = [0.4 0.4 0.4];
            app.FilesPanelLabel.Position = [12 76 200 18];

            app.SpecFileButton = uibutton(app.FilesPanel, 'push');
            app.SpecFileButton.Text = 'Load Spec File';
            app.SpecFileButton.Position = [12 48 130 26];

            app.SpecStatusLabel = uilabel(app.FilesPanel);
            app.SpecStatusLabel.Text = 'Not loaded';
            app.SpecStatusLabel.FontSize = 12;
            app.SpecStatusLabel.FontColor = [0.5 0.5 0.5];
            app.SpecStatusLabel.Position = [150 48 440 26];

            app.NewVintageButton = uibutton(app.FilesPanel, 'push');
            app.NewVintageButton.Text = 'Load Data File';
            app.NewVintageButton.Position = [12 14 130 26];

            app.NewVintageStatusLabel = uilabel(app.FilesPanel);
            app.NewVintageStatusLabel.Text = 'Not loaded';
            app.NewVintageStatusLabel.FontSize = 12;
            app.NewVintageStatusLabel.FontColor = [0.5 0.5 0.5];
            app.NewVintageStatusLabel.Position = [150 14 440 26];

            % Config panel
            app.ConfigPanel = uipanel(app.MainTab);
            app.ConfigPanel.Position = [20 30 740 360];
            app.ConfigPanel.BackgroundColor = [1 1 1];

            app.ConfigPanelLabel = uilabel(app.ConfigPanel);
            app.ConfigPanelLabel.Text = '2 — Configure run';
            app.ConfigPanelLabel.FontSize = 11;
            app.ConfigPanelLabel.FontWeight = 'bold';
            app.ConfigPanelLabel.FontColor = [0.4 0.4 0.4];
            app.ConfigPanelLabel.Position = [12 322 200 18];

            % Target variable
            app.TargetVarLabel = uilabel(app.ConfigPanel);
            app.TargetVarLabel.Text = 'Target variable';
            app.TargetVarLabel.FontSize = 12;
            app.TargetVarLabel.FontColor = [0.4 0.4 0.4];
            app.TargetVarLabel.Position = [12 292 120 18];

            app.TargetVarDropDown = uidropdown(app.ConfigPanel);
            app.TargetVarDropDown.Items = {'GDPC1 - Real GDP'};
            app.TargetVarDropDown.Value = 'GDPC1 - Real GDP';
            app.TargetVarDropDown.Position = [12 266 230 26];

            % Series filter
            app.SeriesFilterLabel = uilabel(app.ConfigPanel);
            app.SeriesFilterLabel.Text = 'Include series';
            app.SeriesFilterLabel.FontSize = 12;
            app.SeriesFilterLabel.FontColor = [0.4 0.4 0.4];
            app.SeriesFilterLabel.Position = [12 234 120 18];

            app.SeriesFilterNoteLabel = uilabel(app.ConfigPanel);
            app.SeriesFilterNoteLabel.Text = '<-- populated from spec file';
            app.SeriesFilterNoteLabel.FontSize = 11;
            app.SeriesFilterNoteLabel.FontColor = [0.30 0.22 0.66];
            app.SeriesFilterNoteLabel.Position = [136 234 230 18];

            % Multi-select listbox of series
            app.SeriesListBox = uilistbox(app.ConfigPanel);
            app.SeriesListBox.Items = {
                'INDPRO - Industrial Production'
                'PAYEMS - Nonfarm Payroll Employment'
                'HOUST  - Housing Starts'
                'DSPIC96 - Real Disp. Personal Income'
                'RSAFS  - Retail Sales'
                'UNRATE - Unemployment Rate'
                'GDPC1  - Real GDP'
                'PCEC96 - Real PCE'
            };
            app.SeriesListBox.Multiselect = 'on';
            app.SeriesListBox.Value = app.SeriesListBox.Items;
            app.SeriesListBox.Position = [12 60 590 168];
            app.SeriesListBox.FontSize = 12;

            app.SelectAllButton = uibutton(app.ConfigPanel, 'push');
            app.SelectAllButton.Text = 'Select all';
            app.SelectAllButton.FontSize = 11;
            app.SelectAllButton.Position = [614 198 114 26];

            app.DeselectAllButton = uibutton(app.ConfigPanel, 'push');
            app.DeselectAllButton.Text = 'Deselect all';
            app.DeselectAllButton.FontSize = 11;
            app.DeselectAllButton.Position = [614 164 114 26];

            app.RunButton = uibutton(app.ConfigPanel, 'push');
            app.RunButton.Text = 'Run model';
            app.RunButton.FontSize = 13;
            app.RunButton.FontWeight = 'bold';
            app.RunButton.BackgroundColor = [0.24 0.20 0.54];
            app.RunButton.FontColor = [1 1 1];
            app.RunButton.Position = [12 14 130 28];

            app.ExportButton = uibutton(app.ConfigPanel, 'push');
            app.ExportButton.Text = 'Export';
            app.ExportButton.FontSize = 12;
            app.ExportButton.Position = [608 14 120 28];

            % ============================================================
            %  RESULTS TAB
            % ============================================================
            app.ResultsTab = uitab(app.TabGroup);
            app.ResultsTab.Title = 'Results';

            app.NowcastPanel = uipanel(app.ResultsTab);
            app.NowcastPanel.Position = [20 468 740 90];
            app.NowcastPanel.BackgroundColor = [0.94 0.93 0.99];

            app.NowcastDateLabel = uilabel(app.NowcastPanel);
            app.NowcastDateLabel.Text = 'GDP nowcast -- 2016:Q4';
            app.NowcastDateLabel.FontSize = 12;
            app.NowcastDateLabel.FontColor = [0.4 0.4 0.4];
            app.NowcastDateLabel.HorizontalAlignment = 'center';
            app.NowcastDateLabel.Position = [0 60 740 20];

            app.NowcastValueLabel = uilabel(app.NowcastPanel);
            app.NowcastValueLabel.Text = '+2.44%';
            app.NowcastValueLabel.FontSize = 40;
            app.NowcastValueLabel.FontWeight = 'bold';
            app.NowcastValueLabel.FontColor = [0.24 0.20 0.54];
            app.NowcastValueLabel.HorizontalAlignment = 'center';
            app.NowcastValueLabel.Position = [0 16 740 44];

            app.NowcastUnitsLabel = uilabel(app.NowcastPanel);
            app.NowcastUnitsLabel.Text = 'QoQ% annualized rate  |  as of Dec 23, 2016';
            app.NowcastUnitsLabel.FontSize = 11;
            app.NowcastUnitsLabel.FontColor = [0.5 0.5 0.5];
            app.NowcastUnitsLabel.HorizontalAlignment = 'center';
            app.NowcastUnitsLabel.Position = [0 2 740 16];

            % Stat cards
            app.PrevVintagePanel = uipanel(app.ResultsTab);
            app.PrevVintagePanel.Position = [20 388 230 72];
            app.PrevVintagePanel.BackgroundColor = [0.96 0.96 0.96];

            app.PrevVintageTitleLabel = uilabel(app.PrevVintagePanel);
            app.PrevVintageTitleLabel.Text = 'Previous vintage';
            app.PrevVintageTitleLabel.FontSize = 11;
            app.PrevVintageTitleLabel.FontColor = [0.5 0.5 0.5];
            app.PrevVintageTitleLabel.Position = [10 50 200 16];

            app.PrevVintageValueLabel = uilabel(app.PrevVintagePanel);
            app.PrevVintageValueLabel.Text = '+2.31%';
            app.PrevVintageValueLabel.FontSize = 22;
            app.PrevVintageValueLabel.FontWeight = 'bold';
            app.PrevVintageValueLabel.Position = [10 22 200 28];

            app.PrevVintageDateLabel = uilabel(app.PrevVintagePanel);
            app.PrevVintageDateLabel.Text = 'Dec 16, 2016';
            app.PrevVintageDateLabel.FontSize = 11;
            app.PrevVintageDateLabel.FontColor = [0.5 0.5 0.5];
            app.PrevVintageDateLabel.Position = [10 4 200 16];

            app.RevisionPanel = uipanel(app.ResultsTab);
            app.RevisionPanel.Position = [265 388 230 72];
            app.RevisionPanel.BackgroundColor = [0.96 0.96 0.96];

            app.RevisionTitleLabel = uilabel(app.RevisionPanel);
            app.RevisionTitleLabel.Text = 'Revision impact';
            app.RevisionTitleLabel.FontSize = 11;
            app.RevisionTitleLabel.FontColor = [0.5 0.5 0.5];
            app.RevisionTitleLabel.Position = [10 50 200 16];

            app.RevisionValueLabel = uilabel(app.RevisionPanel);
            app.RevisionValueLabel.Text = '+0.04%';
            app.RevisionValueLabel.FontSize = 22;
            app.RevisionValueLabel.FontWeight = 'bold';
            app.RevisionValueLabel.FontColor = [0.18 0.49 0.20];
            app.RevisionValueLabel.Position = [10 22 200 28];

            app.RevisionSubLabel = uilabel(app.RevisionPanel);
            app.RevisionSubLabel.Text = 'from data revisions';
            app.RevisionSubLabel.FontSize = 11;
            app.RevisionSubLabel.FontColor = [0.5 0.5 0.5];
            app.RevisionSubLabel.Position = [10 4 200 16];

            app.ReleasePanel = uipanel(app.ResultsTab);
            app.ReleasePanel.Position = [510 388 230 72];
            app.ReleasePanel.BackgroundColor = [0.96 0.96 0.96];

            app.ReleaseTitleLabel = uilabel(app.ReleasePanel);
            app.ReleaseTitleLabel.Text = 'Release impact';
            app.ReleaseTitleLabel.FontSize = 11;
            app.ReleaseTitleLabel.FontColor = [0.5 0.5 0.5];
            app.ReleaseTitleLabel.Position = [10 50 200 16];

            app.ReleaseValueLabel = uilabel(app.ReleasePanel);
            app.ReleaseValueLabel.Text = '+0.09%';
            app.ReleaseValueLabel.FontSize = 22;
            app.ReleaseValueLabel.FontWeight = 'bold';
            app.ReleaseValueLabel.FontColor = [0.18 0.49 0.20];
            app.ReleaseValueLabel.Position = [10 22 200 28];

            app.ReleaseSubLabel = uilabel(app.ReleasePanel);
            app.ReleaseSubLabel.Text = 'from new data releases';
            app.ReleaseSubLabel.FontSize = 11;
            app.ReleaseSubLabel.FontColor = [0.5 0.5 0.5];
            app.ReleaseSubLabel.Position = [10 4 200 16];

            app.NewsTableLabel = uilabel(app.ResultsTab);
            app.NewsTableLabel.Text = 'NEWS DETAIL TABLE';
            app.NewsTableLabel.FontSize = 10;
            app.NewsTableLabel.FontWeight = 'bold';
            app.NewsTableLabel.FontColor = [0.4 0.4 0.4];
            app.NewsTableLabel.Position = [20 366 300 18];

            app.NewsUITable = uitable(app.ResultsTab);
            app.NewsUITable.Position = [20 130 740 232];
            app.NewsUITable.ColumnName = {'Series ID', 'Series Name', 'Forecast', 'Actual', 'Weight', 'Impact (%)'};
            app.NewsUITable.ColumnWidth = {80, 220, 80, 80, 70, 90};
            app.NewsUITable.Data = {
                'INDPRO',  'Industrial Production',       0.31,  0.44,  0.18, '+0.02';
                'PAYEMS',  'Nonfarm Payroll Employment',  156.2, 156.8, 0.29, '+0.06';
                'HOUST',   'Housing Starts',              1.16,  1.09,  0.11, '-0.01';
                'ISM',     'ISM Manufacturing Index',     51.4,  53.2,  0.14, '+0.03';
                'RSAFS',   'Retail Sales',                0.22,  0.19,  0.09, '-0.01';
            };
            app.NewsUITable.RowName = {};

            app.ExportExcelButton = uibutton(app.ResultsTab, 'push');
            app.ExportExcelButton.Text = 'Export to Excel';
            app.ExportExcelButton.FontSize = 12;
            app.ExportExcelButton.Position = [506 88 160 28];

            app.ExportLogButton = uibutton(app.ResultsTab, 'push');
            app.ExportLogButton.Text = 'Export log (.txt)';
            app.ExportLogButton.FontSize = 12;
            app.ExportLogButton.Position = [506 52 160 28];

            % ============================================================
            %  AI COPILOT TAB  (blank placeholder)
            % ============================================================
            app.AICopilotTab = uitab(app.TabGroup);
            app.AICopilotTab.Title = 'AI Copilot';

            % ============================================================
            %  FORECAST DETAILS TAB  (identical to previous Log tab)
            % ============================================================
            app.ForecastDetailsTab = uitab(app.TabGroup);
            app.ForecastDetailsTab.Title = 'Forecast Details';

            app.ForecastDetailsTitleLabel = uilabel(app.ForecastDetailsTab);
            app.ForecastDetailsTitleLabel.Text = 'Model run log';
            app.ForecastDetailsTitleLabel.FontSize = 14;
            app.ForecastDetailsTitleLabel.FontWeight = 'bold';
            app.ForecastDetailsTitleLabel.Position = [20 530 300 24];

            app.ForecastDetailsExportButton = uibutton(app.ForecastDetailsTab, 'push');
            app.ForecastDetailsExportButton.Text = 'Export .txt';
            app.ForecastDetailsExportButton.FontSize = 12;
            app.ForecastDetailsExportButton.Position = [638 530 120 24];

            app.ForecastDetailsTextArea = uitextarea(app.ForecastDetailsTab);
            app.ForecastDetailsTextArea.Position = [20 20 740 504];
            app.ForecastDetailsTextArea.Editable = 'off';
            app.ForecastDetailsTextArea.FontName = 'Courier New';
            app.ForecastDetailsTextArea.FontSize = 11;
            app.ForecastDetailsTextArea.BackgroundColor = [0.12 0.12 0.12];
            app.ForecastDetailsTextArea.FontColor = [0.85 0.85 0.85];
            app.ForecastDetailsTextArea.Value = {
                'Loading data... '
                ''
                'Table 1: Model specification'
                'N =  30 data series'
                'T = 198 observations from 2000-01-01 to 2016-06-01'
                '       Data Series  |      Observations    ...'
                ''
                'Table 2: Data Summary'
                '    ...'
                ''
                'Table 3: Block Loading Structure'
                '    ...'
                ''
                'Estimating the dynamic factor model (DFM) ...'
                ''
                'Now running the 10th iteration of max 5000'
                '  Loglik   (% Change)'
                '  -1243.21   (  0.82%)'
                ''
                'Successful: Convergence at 47 iterations'
                ''
                'Table 4: Factor Loadings for Monthly Series'
                '    ...'
                ''
                'Table 5: Quarterly Loadings Sample (Global Factor)'
                '    ...'
                ''
                'Table 6: Autoregressive Coefficients on Factors'
                '    ...'
                ''
                'Table 7: Autoregressive Coefficients on Idiosyncratic Component'
                '    ...'
                ''
                '--- Nowcast Update ---'
                'Nowcast Update: December 23, 2016'
                'Nowcast for Real Gross Domestic Product (pca), 2016:Q4'
                ''
                '  Nowcast Impact Decomposition'
                '  Dec 16 nowcast:        2.31'
                '  Impact from revisions: 0.04'
                '  Impact from releases:  0.09'
                '                       +_____'
                '  Total impact:          0.13'
                '  Dec 23 nowcast:        2.44'
                ''
                '[Run model to see full output]'
            };

            % ============================================================
            %  FIGURES TAB  (nested tab group)
            % ============================================================
            app.FiguresTab = uitab(app.TabGroup);
            app.FiguresTab.Title = 'Figures';

            app.FiguresTabGroup = uitabgroup(app.FiguresTab);
            app.FiguresTabGroup.Position = [0 0 778 574];

            % ── Fig 1: Raw vs Transformed ────────────────────────────────
            app.Fig1Tab = uitab(app.FiguresTabGroup);
            app.Fig1Tab.Title = 'Fig 1: Data';

            app.Fig1SeriesDropDownLabel = uilabel(app.Fig1Tab);
            app.Fig1SeriesDropDownLabel.Text = 'Series:';
            app.Fig1SeriesDropDownLabel.FontSize = 12;
            app.Fig1SeriesDropDownLabel.FontColor = [0.4 0.4 0.4];
            app.Fig1SeriesDropDownLabel.Position = [20 524 50 22];

            app.Fig1SeriesDropDown = uidropdown(app.Fig1Tab);
            app.Fig1SeriesDropDown.Items = {'INDPRO - Industrial Production', 'PAYEMS - Nonfarm Payrolls', 'GDPC1 - Real GDP'};
            app.Fig1SeriesDropDown.Value = 'INDPRO - Industrial Production';
            app.Fig1SeriesDropDown.Position = [76 524 280 22];

            app.UIAxes_RawData = uiaxes(app.Fig1Tab);
            app.UIAxes_RawData.Position = [20 286 740 230];
            title(app.UIAxes_RawData, 'Raw observed data');
            ylabel(app.UIAxes_RawData, 'Units');
            app.UIAxes_RawData.FontSize = 11;
            app.UIAxes_RawData.Box = 'on';
            text(app.UIAxes_RawData, 0.5, 0.5, 'Run model to populate', ...
                'Units', 'normalized', 'HorizontalAlignment', 'center', ...
                'FontSize', 12, 'Color', [0.7 0.7 0.7]);

            app.UIAxes_TransformedData = uiaxes(app.Fig1Tab);
            app.UIAxes_TransformedData.Position = [20 30 740 230];
            title(app.UIAxes_TransformedData, 'Transformed data');
            ylabel(app.UIAxes_TransformedData, 'Transformed units');
            app.UIAxes_TransformedData.FontSize = 11;
            app.UIAxes_TransformedData.Box = 'on';
            text(app.UIAxes_TransformedData, 0.5, 0.5, 'Run model to populate', ...
                'Units', 'normalized', 'HorizontalAlignment', 'center', ...
                'FontSize', 12, 'Color', [0.7 0.7 0.7]);

            % ── Fig 2: Common Factor ─────────────────────────────────────
            app.Fig2Tab = uitab(app.FiguresTabGroup);
            app.Fig2Tab.Title = 'Fig 2: Common Factor';

            app.UIAxes_CommonFactor = uiaxes(app.Fig2Tab);
            app.UIAxes_CommonFactor.Position = [20 30 740 514];
            title(app.UIAxes_CommonFactor, 'Common factor and standardized data');
            ylabel(app.UIAxes_CommonFactor, 'Standardized value');
            app.UIAxes_CommonFactor.FontSize = 11;
            app.UIAxes_CommonFactor.Box = 'on';
            text(app.UIAxes_CommonFactor, 0.5, 0.5, 'Run model to populate', ...
                'Units', 'normalized', 'HorizontalAlignment', 'center', ...
                'FontSize', 12, 'Color', [0.7 0.7 0.7]);

            % ── Fig 3: Factor Projection ─────────────────────────────────
            app.Fig3Tab = uitab(app.FiguresTabGroup);
            app.Fig3Tab.Title = 'Fig 3: Projection';

            app.Fig3SeriesDropDownLabel = uilabel(app.Fig3Tab);
            app.Fig3SeriesDropDownLabel.Text = 'Top panel series:';
            app.Fig3SeriesDropDownLabel.FontSize = 12;
            app.Fig3SeriesDropDownLabel.FontColor = [0.4 0.4 0.4];
            app.Fig3SeriesDropDownLabel.Position = [20 524 120 22];

            app.Fig3SeriesDropDown = uidropdown(app.Fig3Tab);
            app.Fig3SeriesDropDown.Items = {'PAYEMS - Nonfarm Payrolls', 'INDPRO - Industrial Production', 'HOUST - Housing Starts'};
            app.Fig3SeriesDropDown.Value = 'PAYEMS - Nonfarm Payrolls';
            app.Fig3SeriesDropDown.Position = [148 524 280 22];

            app.Fig3NoteLabel = uilabel(app.Fig3Tab);
            app.Fig3NoteLabel.Text = 'Bottom panel always shows GDPC1';
            app.Fig3NoteLabel.FontSize = 11;
            app.Fig3NoteLabel.FontColor = [0.30 0.22 0.66];
            app.Fig3NoteLabel.Position = [440 526 300 18];

            app.UIAxes_Projection = uiaxes(app.Fig3Tab);
            app.UIAxes_Projection.Position = [20 286 740 230];
            title(app.UIAxes_Projection, 'Common component vs. data (selected series)');
            ylabel(app.UIAxes_Projection, 'Units');
            app.UIAxes_Projection.FontSize = 11;
            app.UIAxes_Projection.Box = 'on';
            text(app.UIAxes_Projection, 0.5, 0.5, 'Run model to populate', ...
                'Units', 'normalized', 'HorizontalAlignment', 'center', ...
                'FontSize', 12, 'Color', [0.7 0.7 0.7]);

            app.UIAxes_GDPProjection = uiaxes(app.Fig3Tab);
            app.UIAxes_GDPProjection.Position = [20 30 740 230];
            title(app.UIAxes_GDPProjection, 'Common component vs. data (GDPC1)');
            ylabel(app.UIAxes_GDPProjection, 'QoQ% ann.');
            app.UIAxes_GDPProjection.FontSize = 11;
            app.UIAxes_GDPProjection.Box = 'on';
            text(app.UIAxes_GDPProjection, 0.5, 0.5, 'Run model to populate', ...
                'Units', 'normalized', 'HorizontalAlignment', 'center', ...
                'FontSize', 12, 'Color', [0.7 0.7 0.7]);

            % ── Spec Comparison ──────────────────────────────────────────
            app.SpecCompTab = uitab(app.FiguresTabGroup);
            app.SpecCompTab.Title = 'Spec Comparison';

            app.UIAxes_NowcastOverlay = uiaxes(app.SpecCompTab);
            app.UIAxes_NowcastOverlay.Position = [20 200 740 344];
            title(app.UIAxes_NowcastOverlay, 'GDP nowcast: original vs. modified spec');
            ylabel(app.UIAxes_NowcastOverlay, 'Real GDP growth (ann. %)');
            app.UIAxes_NowcastOverlay.FontSize = 11;
            app.UIAxes_NowcastOverlay.Box = 'on';
            text(app.UIAxes_NowcastOverlay, 0.5, 0.5, 'Run model to populate', ...
                'Units', 'normalized', 'HorizontalAlignment', 'center', ...
                'FontSize', 12, 'Color', [0.7 0.7 0.7]);

            app.UIAxes_Diff = uiaxes(app.SpecCompTab);
            app.UIAxes_Diff.Position = [20 30 740 156];
            title(app.UIAxes_Diff, 'Difference (modified - original)');
            xlabel(app.UIAxes_Diff, 'Quarter');
            ylabel(app.UIAxes_Diff, 'Delta ann. %');
            app.UIAxes_Diff.FontSize = 11;
            app.UIAxes_Diff.Box = 'on';
            text(app.UIAxes_Diff, 0.5, 0.5, 'Run model to populate', ...
                'Units', 'normalized', 'HorizontalAlignment', 'center', ...
                'FontSize', 12, 'Color', [0.7 0.7 0.7]);

            % ── News ─────────────────────────────────────────────────────
            app.NewsTab = uitab(app.FiguresTabGroup);
            app.NewsTab.Title = 'News';

            app.NewsNoteLabel = uilabel(app.NewsTab);
            app.NewsNoteLabel.Text = 'Requires old and new vintage both loaded on the Main tab.';
            app.NewsNoteLabel.FontSize = 12;
            app.NewsNoteLabel.FontColor = [0.5 0.5 0.5];
            app.NewsNoteLabel.Position = [20 528 700 22];

            app.UIAxes_News = uiaxes(app.NewsTab);
            app.UIAxes_News.Position = [20 30 740 490];
            title(app.UIAxes_News, 'Block contribution to nowcast update');
            xlabel(app.UIAxes_News, 'Mean contribution of difference (ann. %)');
            ylabel(app.UIAxes_News, 'Block');
            app.UIAxes_News.FontSize = 12;
            app.UIAxes_News.Box = 'on';
            text(app.UIAxes_News, 0.5, 0.5, 'Run model with both vintages to populate', ...
                'Units', 'normalized', 'HorizontalAlignment', 'center', ...
                'FontSize', 12, 'Color', [0.7 0.7 0.7]);

            app.UIFigure.Visible = 'on';
        end
    end

    methods (Access = public)

        function app = app1_mockup
            createComponents(app)
            registerApp(app, app.UIFigure)
            if nargout == 0
                clear app
            end
        end

        function delete(app)
            delete(app.UIFigure)
        end
    end
end
