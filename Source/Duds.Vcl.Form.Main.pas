// -----------------------------------------------------------------------------
//
// The contents of this file are subject to the Mozilla Public License
// Version 2.0 (the "License"); you may not use this file except in compliance
// with the License. You may obtain a copy of the License at
// http://www.mozilla.org/MPL/
//
// Alternatively, you may redistribute this library, use and/or modify it under
// the terms of the GNU Lesser General Public License as published by the
// Free Software Foundation; either version 2.1 of the License, or (at your
// option) any later version. You may obtain a copy of the LGPL at
// http://www.gnu.org/copyleft/.
//
// Software distributed under the License is distributed on an "AS IS" basis,
// WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
// the specific language governing rights and limitations under the License.
//
// Orginally released as freeware then open sourced in July 2017.
//
// The initial developer of the original code is Easy-IP AS
// (Oslo, Norway, www.easy-ip.net), written by Paul Spencer Thornton -
// paul.thornton@easy-ip.net.
//
// (C) 2017 Easy-IP AS. All Rights Reserved.
//
// -----------------------------------------------------------------------------

unit Duds.Vcl.Form.Main;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.ImageList,
  System.Actions, System.DateUtils,
  System.Generics.Collections, System.UITypes, System.IOUtils,

  Xml.XMLDoc, Xml.XMLIntf,

  Winapi.Windows, Winapi.Messages, Winapi.ShellAPI,
  System.Win.Registry,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.ActnList, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ImgList, Vcl.ActnCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.Mask,
  Vcl.Menus,

  VirtualTrees,

  SynEditHighlighter, SynHighlighterPas, SynEdit,

  Duds.Common.Types,
  Duds.Common.Classes,
  Duds.Common.Files,
  Duds.Common.Strings,
  Duds.Common.Utils,
  Duds.Common.Interfaces,
  Duds.Common.UnitInfo,
  Duds.Common.UsedUnitInfo,
  Duds.Common.Refactoring,
  Duds.Common.Language,
  Duds.Common.Log,
  Duds.Scan.Model,
  Duds.Scan.FileScanner,
  Duds.Scan.DependencyAnalyzer,
  Duds.Export.Gephi,
  Duds.Export.GraphML,
  Duds.Modules.Classes,
  Duds.Modules.Analyzer,
  Duds.Modules.Export.CSV,
  Duds.Modules.Export.GraphML,
  Duds.Refactoring.FormatUses,
  Duds.Refactoring.RenameUnit,
  Duds.Refactoring.AddUnitToUses,
  Duds.Refactoring.PascalAnalyzerUsesReportProcessor,
  Duds.Refactoring.RemoveUnusedUnits,

  Duds.Vcl.HourGlass,
  Duds.Vcl.Utils,
  Duds.Vcl.VirtualTreeview;

type
  TfrmMain = class(TForm)
    SynPasSyn1: TSynPasSyn;
    ActionManager1: TActionManager;
    actStartScan: TAction;
    actShowUnitsNotInPath: TAction;
    actSaveChanges: TAction;
    actRename: TAction;
    actApplyRenameList: TAction;
    popTree: TPopupMenu;
    Rename1: TMenuItem;
    ShowUnitsnotinPath1: TMenuItem;
    N1: TMenuItem;
    actExpandAll: TAction;
    actExpand: TAction;
    actCollapseAll: TAction;
    actCollapse: TAction;
    N3: TMenuItem;
    Expand1: TMenuItem;
    ExpandAll1: TMenuItem;
    Collapse1: TMenuItem;
    CollapseAll1: TMenuItem;
    N4: TMenuItem;
    actStopScan: TAction;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    actSettings: TAction;
    Settings1: TMenuItem;
    N5: TMenuItem;
    actExit: TAction;
    Exit1: TMenuItem;
    Scan1: TMenuItem;
    View1: TMenuItem;
    Scan2: TMenuItem;
    Stop1: TMenuItem;
    ShowUnitsnotinPath2: TMenuItem;
    N6: TMenuItem;
    ExpandAll2: TMenuItem;
    CollapseAll2: TMenuItem;
    Edit1: TMenuItem;
    Rename2: TMenuItem;
    SaveChanges1: TMenuItem;
    N7: TMenuItem;
    actLoadProject: TAction;
    actSaveProject: TAction;
    actSaveProjectAs: TAction;
    LoadProject1: TMenuItem;
    SaveProject1: TMenuItem;
    SaveProjectAs1: TMenuItem;
    N2: TMenuItem;
    N8: TMenuItem;
    openDialog_Project: TOpenDialog;
    saveDialog_Project: TSaveDialog;
    OpenDialogMultipleRenames: TOpenDialog;
    ActionToolBar1: TActionToolBar;
    pnlBackground: TPanel;
    pnlMain: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    pcView: TPageControl;
    tabTree: TTabSheet;
    Splitter2: TSplitter;
    pnlTree: TPanel;
    Panel5: TPanel;
    pcSource: TPageControl;
    tabParentFile: TTabSheet;
    memParentFile: TSynEdit;
    tabSelectedFile: TTabSheet;
    memSelectedFile: TSynEdit;
    tabList: TTabSheet;
    Splitter3: TSplitter;
    pnlList: TPanel;
    Panel10: TPanel;
    pnlLog: TPanel;
    Panel9: TPanel;
    pcList: TPageControl;
    tabUsedBy: TTabSheet;
    tabSource: TTabSheet;
    memListFile: TSynEdit;
    tmrClose: TTimer;
    tabUsesList: TTabSheet;
    actNewProject: TAction;
    actCloseProject: TAction;
    New1: TMenuItem;
    N10: TMenuItem;
    Close1: TMenuItem;
    N9: TMenuItem;
    actSearchAndReplace: TAction;
    SearchandReplace1: TMenuItem;
    tmrLoaded: TTimer;
    actShowFile: TAction;
    ShowfileinWindowsExplorer1: TMenuItem;
    N11: TMenuItem;
    actSaveToXML: TAction;
    saveDialog_Units_XML: TSaveDialog;
    actSaveToGephiCSV: TAction;
    N12: TMenuItem;
    SavetoXML1: TMenuItem;
    SavetoGephiCSV1: TMenuItem;
    saveDialog_Units_GephiCSV: TSaveDialog;
    actSaveToGraphML: TAction;
    saveDialog_Units_GraphML: TSaveDialog;
    edtSearch: TEdit;
    edtListSearch: TEdit;
    edtSearchUsedByList: TEdit;
    edtSearchUsesList: TEdit;
    vtUnitsList: TVirtualStringTree;
    vtUnitsTree: TVirtualStringTree;
    vtUsedByUnits: TVirtualStringTree;
    vtUsesUnits: TVirtualStringTree;
    vtStats: TVirtualStringTree;
    ImageList1: TImageList;
    vtLog: TVirtualStringTree;
    SearchandReplace2: TMenuItem;
    N13: TMenuItem;
    actSaveCircularRefs: TAction;
    Savecircularreference1: TMenuItem;
    RichEditUnitPath: TRichEdit;
    PanelFooter: TPanel;
    Splitter4: TSplitter;
    actAddUnitToUses: TAction;
    Applymultiplerenamesdefinedincsv1: TMenuItem;
    Addunittouseslistinallfilesthatcurrentlyusethisunit1: TMenuItem;
    N14: TMenuItem;
    Addunittouseslistinallfilesthatcurrentlyusethisunit2: TMenuItem;
    actRefactoringsDropDown: TAction;
    actExportDropDown: TAction;
    actRemoveUnusedUnitsProcessPalOutput: TAction;
    actRemoveUnUsedUnits: TAction;
    actFormatUsesOfFile: TAction;
    Refactorings1: TMenuItem;
    Formatusesofthisfile1: TMenuItem;
    Formatusesofthisfile2: TMenuItem;
    N15: TMenuItem;
    actExportModulesToGraphML: TAction;
    saveDialog_Modules_GraphML: TSaveDialog;
    Modules: TTabSheet;
    vtModules: TVirtualStringTree;
    actExportModulesToCSV: TAction;
    saveDialog_Modules_CSV: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtUnitsTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure vtUnitsTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure edtSearchEditChange(Sender: TObject);
    procedure vtUnitsTreePaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtUnitsTreeDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
        Node: PVirtualNode; Column: TColumnIndex; const Text: string; const
        CellRect: TRect; var DefaultDraw: Boolean);      
    procedure vtUnitsTreeBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
      ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
    procedure vtUnitsTreeFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure vtUnitsTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure vtUnitsTreeDblClick(Sender: TObject);
    procedure actStartScanExecute(Sender: TObject);
    procedure actShowUnitsNotInPathExecute(Sender: TObject);
    procedure ActionManager1Update(Action: TBasicAction; var Handled: Boolean);
    procedure vtUnitsTreeFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode;
      OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
    procedure memParentFileChange(Sender: TObject);
    procedure memSelectedFileChange(Sender: TObject);
    procedure actSaveChangesExecute(Sender: TObject);
    procedure actRenameExecute(Sender: TObject);
    procedure edtSearchEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSearchEditKeyPress(Sender: TObject; var Key: Char);
    procedure actExpandAllExecute(Sender: TObject);
    procedure actExpandExecute(Sender: TObject);
    procedure actCollapseAllExecute(Sender: TObject);
    procedure actCollapseExecute(Sender: TObject);
    procedure vtUnitsListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType; var CellText: string);
    procedure vtStatsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vtStatsPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vtUnitsListFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode;
      OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
    procedure vtUnitsListFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
    procedure vtUnitsListSearchComparison(Sender: TObject; Node: PVirtualNode; const SearchTerms: TStrings;
      var IsMatch: Boolean);
    procedure edtListSearchEditChange(Sender: TObject);
    procedure vtUnitsListDblClick(Sender: TObject);
    procedure vtUnitsListPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure actStopScanExecute(Sender: TObject);
    procedure memListFileChange(Sender: TObject);
    procedure vtUnitsListCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
      var Result: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure vtUnitsTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
      var Result: Integer);
    procedure actExitExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actLoadProjectExecute(Sender: TObject);
    procedure actSaveProjectExecute(Sender: TObject);
    procedure actSaveProjectAsExecute(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
    procedure edtSearchUsedByListEditChange(Sender: TObject);
    procedure edtSearchUsesListEditChange(Sender: TObject);
    procedure actNewProjectExecute(Sender: TObject);
    procedure actCloseProjectExecute(Sender: TObject);
    procedure actSearchAndReplaceExecute(Sender: TObject);
    procedure edtSearchSearchClick(Sender: TObject);
    procedure tmrLoadedTimer(Sender: TObject);
    procedure actShowFileExecute(Sender: TObject);
    procedure actSaveToXMLExecute(Sender: TObject);
    procedure actSaveToGephiCSVExecute(Sender: TObject);
    procedure actSaveToGraphMLExecute(Sender: TObject);
    procedure vtLogGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure vtCommonHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vtLogGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure vtCommonGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
      Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
    procedure actSaveCircularRefsExecute(Sender: TObject);
    procedure actApplyRenameListExecute(Sender: TObject);
    procedure actAddUnitToUsesExecute(Sender: TObject);
    procedure actExportModulesToCSVExecute(Sender: TObject);
    procedure actExportModulesToGraphMLExecute(Sender: TObject);
    procedure actRemoveUnUsedUnitsExecute(Sender: TObject);
    procedure actRemoveUnusedUnitsProcessPalOutputExecute(Sender: TObject);
    procedure actFormatUsesOfFileExecute(Sender: TObject);
    procedure vtModulesDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas;
        Node: PVirtualNode; Column: TColumnIndex; const Text: string; const
        CellRect: TRect; var DefaultDraw: Boolean);
    procedure vtModulesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
        Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vtUnitsListDrawText(Sender: TBaseVirtualTree; TargetCanvas:
        TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string;
        const CellRect: TRect; var DefaultDraw: Boolean);
  private
    FModel: TDudsModel;
    FDependencyAnalyzer: TDudsDependencyAnalyzer;
    FTreeNodeObjects: TObjectList<TNodeObject>;
    FSearchText: String;
    FLineCount: Integer;
    FStats: TStringList;
    FScannedUsesCount: Integer;
    FSemiCircularFiles: Integer;
    FCircularFiles: Integer;
    FScanDepth: Integer;
    FCancelled: Boolean;
    FStartTime: TDateTime;
    FBusy: Boolean;
    FpnlLogHeight: Integer;
    FEnvironmentSettings: TEnvironmentSettings;
    FProjectSettings: TProjectSettings;
    FProjectFilename: String;
    FLoadLastProject: Boolean;
    FModified: Boolean;
    FParsedFileCount: Integer;
    FFMXFormCount: Integer;
    FVCLFormCount: Integer;
    FFilesNotInPath: Integer;
    FNextStatusUpdate: TDateTime;
    FDeepestScanDepth: Integer;
    FClosing: Boolean;
    FShowTermParents: Boolean;
    FRunScanOnLoad: Boolean;

    procedure FillGUIFromModel;
    procedure SearchTree(const SearchText: String; FromFirstNode: Boolean);
    function IsSearchHitNode(Node: PVirtualNode): Boolean;
    function GetNodePath(Node: PVirtualNode): String;
    procedure SetNodePathRichEdit(Node: PVirtualNode; ARichEdit: TRichEdit);
    procedure ShowUnitsNotInPath;
    procedure SetNodeVisibility(VT: TVirtualStringTree; Node: PVirtualNode; DelphiFile: TDelphiFile);
    function GetLinkedNode(Node: PVirtualNode): PVirtualNode;
    procedure UpdateTreeControls(Node: PVirtualNode);
    procedure UpdateStats(ForceUpdate: Boolean);
    procedure UpdateListControls(Node: PVirtualNode);
    procedure ShowHideControls;
    procedure LoadSettings;
    procedure SaveSettings;
    function LoadProjectSettings(const Filename: String = ''; RunScanAfterLoad: Boolean = TRUE): Boolean;
    procedure SaveProjectSettings(const Filename: String = '');
    function GetSettingsFilename: String;
    procedure ExpandAll;
    procedure UpdateControls;
    procedure SetFormCaption;
    procedure SetModified(const Value: Boolean);
    function CheckSaveProject: Boolean;
    function SaveProject: Boolean;
    function SaveProjectAs: Boolean;
    function RenameDelphiFileWithDialog(RenameType: TRenameType): Boolean; overload;
    function RenameDelphiFileWithDialog(const DelphiFile: TDelphiFile; RenameType: TRenameType): Boolean; overload;
    procedure ApplyMultipleRenames(aCsvFilename: String; DummyRun, RenameHistoryFiles, InsertOldNameComment,
      RenameLowerCaseExtension: Boolean);
    procedure RenameDelphiFile(const aClearLog: Boolean; const SearchString, ReplaceString: String;
      const DummyRun, RenameHistoryFiles, ExactMatch, InsertOldNameComment,
      LowerCaseExtension: Boolean);
    procedure SearchList(VT: TVirtualStringTree; const SearchText: String);
    procedure SearchUnitsListChildList(VT: TVirtualStringTree; const SearchText: String; UsedBy: Boolean);
    procedure ClearGUIAndModelAndCloseControls;
    function CheckNotRunning: Boolean;
    procedure ResetSettings;
    procedure ClearStats;
    function GetFocusedDelphiFile: TDelphiFile;
    procedure ExportToXML(const VT: TVirtualStringTree; const Filename: String);

    procedure Log(const Msg: String; const Severity: Integer = LogInfo); overload;
    procedure Log(const Msg: String; const Args: array of const; const Severity: Integer = LogInfo); overload;

    function GetID(const Node: PVirtualNode): Integer;
    procedure SetID(const Node: PVirtualNode; const ID: Integer);
    function GetFocusedID(const VT: TVirtualStringTree): Integer;
    function GetNodeIndex(const Node: PVirtualNode): Integer;
    procedure UpdateLogEntries;
    procedure ClearLog;
    procedure FixDPI;
    function CompareTwoModulesTreeNodes(aDelphiFile1,
      aDelphiFile2: TDelphiFile): Integer;
    procedure SetupUnitsListsColumns(tree: TVirtualStringTree);

    property Modified: Boolean read FModified write SetModified;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Duds.Vcl.Form.Rename,
  Duds.Vcl.Form.Settings,
  Duds.Vcl.Form.FindReplace,
  Duds.Vcl.Form.AddUnitToUses;

const
  cNotInSearchpathForegroundColor = clGray;

  cUnknownModuleBackgroundColor   = $000021DB;
  cUnknownModuleForegroundColor   = $00FAFAFA;

{$R *.dfm}

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FClosing then
    ClearGUIAndModelAndCloseControls
  else
  begin
    CanClose := FALSE;

    if CheckSaveProject then
    begin
      actStopScan.Execute;

      tmrClose.Enabled := TRUE;
    end;
  end;
end;

function TfrmMain.CheckSaveProject: Boolean;
begin
  Result := not Modified;

  if not Result then
  begin
    case MessageDlg(StrTheProjectHasBeen, mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        Result := SaveProject;
      mrNo:
        Result := TRUE;
      mrCancel:
        Abort;
    end;
  end;
end;

function TfrmMain.GetID(const Node: PVirtualNode): Integer;
var
  NodeData: PNodeData;
begin
  NodeData := Node.GetData;

  if Assigned(NodeData) then
  begin
    Result := NodeData.ID;
  end
  else
  begin
    raise Exception.Create('No node data found');
  end;
end;

procedure TfrmMain.SetID(const Node: PVirtualNode; const ID: Integer);
var
  NodeData: PNodeData;
begin
  NodeData := Node.GetData;

  if Assigned(NodeData) then
  begin
    NodeData.ID := ID;
    NodeData.Index := Node.Index;
  end;
end;

const
  cvtUnitsList_ColumnIdx_Unit              = 0;
  cvtUnitsList_ColumnIdx_FileType          = 1;
  cvtUnitsList_ColumnIdx_LoC               = 2;
  cvtUnitsList_ColumnIdx_UsedByUnits_Count = 3;
  cvtUnitsList_ColumnIdx_UsedUnits_Count   = 4;
  cvtUnitsList_ColumnIdx_FileName          = 5;
  cvtUnitsList_ColumnIdx_Module            = 6;

procedure TfrmMain.SetupUnitsListsColumns(tree: TVirtualStringTree);
var
  aColumn: TVirtualTreeColumn;
begin
  tree.Header.Columns.Clear;

  aColumn           := tree.Header.Columns.Add; // Column Index 0
  aColumn.Text      := 'Unit';

  aColumn           := tree.Header.Columns.Add; // Column Index 1
  aColumn.Text      := 'File Type';

  aColumn           := tree.Header.Columns.Add; // Column Index 2
  aColumn.Text      := 'LoC';
  aColumn.Alignment := taRightJustify;

  aColumn           := tree.Header.Columns.Add; // Column Index 3
  aColumn.Text      := 'Used By Units';
  aColumn.Alignment := taRightJustify;

  aColumn           := tree.Header.Columns.Add; // Column Index 4
  aColumn.Text      := 'Used Units';
  aColumn.Alignment := taRightJustify;

  aColumn           := tree.Header.Columns.Add; // Column Index 5
  aColumn.Text      := 'Filename';

  aColumn           := tree.Header.Columns.Add; // Column Index 6
  aColumn.Text      := 'Module';
  aColumn.Position  := 5; // bring before 'Filename'
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  pcSource.ActivePageIndex := 0;
  pcView.ActivePageIndex := 0;
  pcList.ActivePageIndex := 0;

  // Units tree
  vtUnitsTree.NodeDataSize := SizeOf(TNodeData);

  // Units lists (3x)
  vtUnitsList.NodeDataSize   := SizeOf(TNodeData);
  SetupUnitsListsColumns(vtUnitsList);
  vtUsedByUnits.NodeDataSize := SizeOf(TNodeData);
  SetupUnitsListsColumns(vtUsedByUnits);
  vtUsesUnits.NodeDataSize   := SizeOf(TNodeData);
  SetupUnitsListsColumns(vtUsesUnits);


  vtStats.NodeDataSize := SizeOf(TNodeData);
  vtModules.NodeDataSize := SizeOf(TNodeData);

  FModel := TDudsModel.Create;
  FDependencyAnalyzer := nil;
  FTreeNodeObjects := TObjectList<TNodeObject>.Create(TRUE);
  FStats := TStringList.Create;

  FEnvironmentSettings := TEnvironmentSettings.Create;
  FProjectSettings := TProjectSettings.Create;

  UpdateTreeControls(nil);
  UpdateListControls(nil);

  FLoadLastProject := TRUE;
  FShowTermParents := FALSE;
  FRunScanOnLoad := TRUE;

  FixDPI;

  LoadSettings;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  SaveSettings;

  FreeAndNil(FModel);
  FreeAndNil(FTreeNodeObjects);
  FreeAndNil(FStats);
  FreeAndNil(FEnvironmentSettings);
  FreeAndNil(FProjectSettings);
end;

procedure TfrmMain.Log(const Msg: String; const Severity: Integer);
begin
  TDudsLogger.GetInstance.Log(Msg, Severity);
  UpdateLogEntries;
end;

procedure TfrmMain.Log(const Msg: String; const Args: array of const; const Severity: Integer);
begin
  Log(Format(Msg, Args), Severity);
end;

function TfrmMain.LoadProjectSettings(const Filename: String; RunScanAfterLoad: Boolean): Boolean;
begin
  Result := FALSE;

  if FProjectSettings.LoadFromFile(Filename) then
  begin
    if (FProjectFilename <> '') and (RunScanAfterLoad) and (FRunScanOnLoad) and (FProjectSettings.RootFiles.Count > 0)
    then
      actStartScan.Execute;

    SetFormCaption;

    Result := TRUE;
  end;
end;

function TfrmMain.GetSettingsFilename: String;
begin
  Result := IncludeTrailingPathDelimiter(TPath.GetDocumentsPath) + 'DUDS\config.ini';
end;

procedure TfrmMain.LoadSettings;
begin
  if FEnvironmentSettings.LoadFromFile(GetSettingsFilename) then
  begin
    pnlLog.Height := FEnvironmentSettings.StatusLogHeight;
    pnlTree.Width := FEnvironmentSettings.TreeWidth;
    pnlList.Width := FEnvironmentSettings.ListWidth;
    actShowUnitsNotInPath.Checked := FEnvironmentSettings.ShowUnitsNotInPath;
    FLoadLastProject := FEnvironmentSettings.LoadLastProject;
    FProjectFilename := FEnvironmentSettings.ProjectFilename;
    FRunScanOnLoad := FEnvironmentSettings.RunScanOnLoad;

    Left := FEnvironmentSettings.WindowLeft;
    Top := FEnvironmentSettings.WindowTop;
    Width := FEnvironmentSettings.WindowWidth;
    Height := FEnvironmentSettings.WindowHeight;
    PanelFooter.Height := FEnvironmentSettings.UnitPatchHeight;

    WindowState := TWindowState(FEnvironmentSettings.WindowState);
  end;
end;

procedure TfrmMain.memListFileChange(Sender: TObject);
begin
  memListFile.Modified := TRUE;
end;

procedure TfrmMain.memParentFileChange(Sender: TObject);
begin
  memParentFile.Modified := TRUE;
end;

procedure TfrmMain.memSelectedFileChange(Sender: TObject);
begin
  memSelectedFile.Modified := TRUE;
end;

procedure TfrmMain.edtListSearchEditChange(Sender: TObject);
begin
  SearchList(vtUnitsList, edtListSearch.Text);
end;

procedure TfrmMain.edtSearchEditChange(Sender: TObject);
begin
  SearchTree(edtSearch.Text, TRUE);
end;

procedure TfrmMain.edtSearchEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 00;

    if edtSearch.Text <> '' then
      SearchTree(edtSearch.Text, FALSE);
  end;
end;

procedure TfrmMain.ClearLog;
begin
  TDudsLogger.GetInstance.Clear;
  UpdateLogEntries;
end;

procedure TfrmMain.edtSearchEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    Key := #00;
end;

procedure TfrmMain.edtSearchSearchClick(Sender: TObject);
begin
  SearchTree(edtSearch.Text, FALSE);
end;

procedure TfrmMain.edtSearchUsedByListEditChange(Sender: TObject);
begin
  SearchUnitsListChildList(vtUsedByUnits, edtSearchUsedByList.Text, TRUE);
end;

procedure TfrmMain.edtSearchUsesListEditChange(Sender: TObject);
begin
  SearchUnitsListChildList(vtUsesUnits, edtSearchUsesList.Text, FALSE);
end;

function TfrmMain.GetFocusedID(const VT: TVirtualStringTree): Integer;
begin
  Result := GetID(VT.FocusedNode);
end;

// search detail-list "Uses Unit" or "Used by Unit"
procedure TfrmMain.SearchUnitsListChildList(VT: TVirtualStringTree; const SearchText: String; UsedBy: Boolean);
var
  Node: PVirtualNode;
  LowerSearchText, UsesOrUsedUnitName: String;
  UsesOrUsedDelphiFile, DelphiFile: TDelphiFile;
  InSearchPathOrShowAll,
  UnitMatchesList, UnitMatchesSearchTerm: Boolean;
begin
  VT.BeginUpdate;
  try
    LowerSearchText := LowerCase(SearchText);

    Node := VT.GetFirst;

    while Node <> nil do
    begin
      DelphiFile := FModel.DelphiFileList[GetID(Node)];

      if UsedBy then
        UnitMatchesList := FModel.IsUnitUsed(
          FModel.DelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.DelphiUnitName,
          DelphiFile)
      else
        UnitMatchesList := FModel.IsUnitUsed(
          DelphiFile.UnitInfo.DelphiUnitName,
          FModel.DelphiFileList[GetFocusedID(vtUnitsList)]);

      InSearchPathOrShowAll := DelphiFile.InSearchPath or (not DelphiFile.InSearchPath and
        actShowUnitsNotInPath.Checked);
      UnitMatchesSearchTerm := ((LowerSearchText = '') or ((pos(LowerSearchText, LowerCase(DelphiFile.UnitInfo.DelphiUnitName)) <> 0)));

      VT.IsVisible[Node] := UnitMatchesSearchTerm and InSearchPathOrShowAll and UnitMatchesList;

      Node := Node.NextSibling;
    end;

    VT.Invalidate;
  finally
    VT.EndUpdate;
  end;
end;

procedure TfrmMain.SaveProjectSettings(const Filename: String);
begin
  if Filename <> '' then
  begin
    FProjectSettings.SaveToFile(Filename);

    Modified := FALSE;
  end;
end;

procedure TfrmMain.SaveSettings;
begin
  FEnvironmentSettings.StatusLogHeight := pnlLog.Height;
  FEnvironmentSettings.TreeWidth := pnlTree.Width;
  FEnvironmentSettings.ListWidth := pnlList.Width;
  FEnvironmentSettings.ShowUnitsNotInPath := actShowUnitsNotInPath.Checked;
  FEnvironmentSettings.LoadLastProject := FLoadLastProject;
  FEnvironmentSettings.ProjectFilename := FProjectFilename;
  FEnvironmentSettings.RunScanOnLoad := FRunScanOnLoad;

  FEnvironmentSettings.WindowLeft := Left;
  FEnvironmentSettings.WindowTop := Top;
  FEnvironmentSettings.WindowWidth := Width;
  FEnvironmentSettings.WindowHeight := Height;
  FEnvironmentSettings.UnitPatchHeight := PanelFooter.Height;

  FEnvironmentSettings.WindowState := Integer(WindowState);

  ForceDirectories(ExtractFileDir(GetSettingsFilename));
  FEnvironmentSettings.SaveToFile(GetSettingsFilename);
end;

// search list "Unit list"
procedure TfrmMain.SearchList(VT: TVirtualStringTree; const SearchText: String);
var
  Node: PVirtualNode;
  LowerSearchText: String;
  DelphiFile: TDelphiFile;
  InSearchPathOrShowAll,
  UnitMatchesSearchTerm: Boolean;
begin
  VT.BeginUpdate;
  try
    LowerSearchText := LowerCase(SearchText);

    Node := VT.GetFirst;

    while Node <> nil do
    begin
      DelphiFile := FModel.DelphiFileList[GetID(Node)];

      InSearchPathOrShowAll := DelphiFile.InSearchPath or (not DelphiFile.InSearchPath and actShowUnitsNotInPath.Checked);
      UnitMatchesSearchTerm := (LowerSearchText = '')
                               or ((pos(LowerSearchText, LowerCase(DelphiFile.UnitInfo.DelphiUnitName)) <> 0))
                               or ((DelphiFile.UnitInfo.Module <> nil) and (Pos(LowerSearchText, LowerCase(DelphiFile.UnitInfo.Module.Name)) > 0));

      VT.IsVisible[Node] :=  UnitMatchesSearchTerm and InSearchPathOrShowAll;

      Node := Node.NextSibling;
    end;

    VT.Invalidate;
  finally
    VT.EndUpdate;
  end;
end;

procedure TfrmMain.SearchTree(const SearchText: String; FromFirstNode: Boolean);
var
  Node, EndNode, ParentStepNode: PVirtualNode;
begin
  vtUnitsTree.BeginUpdate;
  try
    FSearchText := LowerCase(SearchText);

    if (vtUnitsTree.FocusedNode = nil) or (FromFirstNode) then
    begin
      Node := vtUnitsTree.GetFirst;

      EndNode := nil;
    end
    else
    begin
      Node := vtUnitsTree.GetNext(vtUnitsTree.FocusedNode);

      if Node = nil then
        Node := vtUnitsTree.GetFirst;

      EndNode := vtUnitsTree.GetPrevious(Node);
    end;

    while Node <> EndNode do
    begin
      if IsSearchHitNode(Node) then
      begin
        if vtUnitsTree.IsVisible[Node] then
        begin
          vtUnitsTree.SelectNodeEx(Node, TRUE, TRUE);

          if not FShowTermParents then
            Break;
        end;

        if FShowTermParents then
        begin
          ParentStepNode := Node.Parent;

          while ParentStepNode <> vtUnitsTree.RootNode do
          begin
            if FTreeNodeObjects[GetID(ParentStepNode)].SearchTermInChildren then
              Break
            else
              FTreeNodeObjects[GetID(ParentStepNode)].SearchTermInChildren := TRUE;

            ParentStepNode := ParentStepNode.Parent;
          end;
        end;
      end
      else
        FTreeNodeObjects[GetID(Node)].SearchTermInChildren := FALSE;

      Node := vtUnitsTree.GetNext(Node);

      if (Node = nil) and (EndNode <> nil) then
        Node := vtUnitsTree.GetFirst;
    end;

    vtUnitsTree.Invalidate;
  finally
    vtUnitsTree.EndUpdate;
  end;
end;

procedure TfrmMain.vtLogGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected]) and (Column <= 0) then
  begin
    case TDudsLogger.GetInstance.LogEntries[Node.Index].Severity of
      LogWarning:
        ImageIndex := 4;
      LogError:
        ImageIndex := 5;
    else
      ImageIndex := 3;
    end;
  end;
end;

procedure TfrmMain.vtLogGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
begin
  CellText := TDudsLogger.GetInstance.LogEntries[Node.Index].Text;
end;

procedure TfrmMain.vtStatsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  Stat: String;
begin
  Stat := FStats[Node.Index];

  case Column of
    0:
      CellText := Copy(Stat, 1, pos('=', Stat) - 1);
    1:
      CellText := Copy(Stat, pos('=', Stat) + 1, MaxInt);
  end;
end;

procedure TfrmMain.vtStatsPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
begin
  if Column = 0 then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];
end;

procedure TfrmMain.vtUnitsTreeBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
begin
  if IsSearchHitNode(Node) then
  begin
    EraseAction := eaColor;
    ItemColor := $008CFFFF;
  end
  else if (FTreeNodeObjects[GetID(Node)].SearchTermInChildren) or
    ((Node.Parent <> Sender.RootNode) and (FTreeNodeObjects[GetID(Node.Parent)].SearchTermInChildren)) then
  begin
    EraseAction := eaColor;
    ItemColor := $00CCFFCC;
  end;
end;

function TfrmMain.CompareTwoModulesTreeNodes(aDelphiFile1, aDelphiFile2: TDelphiFile): Integer;
var
  aText1,
  aText2: string;
begin
  aText1 := '';
  aText2 := '';

  if aDelphiFile1.UnitInfo.Module <> nil then
    aText1 := aDelphiFile1.UnitInfo.Module.Name;

  if aDelphiFile2.UnitInfo.Module <> nil then
    aText2 := aDelphiFile2.UnitInfo.Module.Name;

  Result := CompareStr(aText1, aText2);
end;

procedure TfrmMain.vtUnitsTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  NodeObject1, NodeObject2: TNodeObject;
begin
  NodeObject1 := FTreeNodeObjects[GetID(Node1)];
  NodeObject2 := FTreeNodeObjects[GetID(Node2)];

  case Column of
    0:
      Result := CompareStr(NodeObject1.DelphiFile.UnitInfo.DelphiUnitName,
        NodeObject2.DelphiFile.UnitInfo.DelphiUnitName);
    1:
      Result := CompareStr(NodeObject1.DelphiFile.UnitInfo.PreviousUnitName,
        NodeObject2.DelphiFile.UnitInfo.PreviousUnitName);
    2:
      Result := CompareStr(DelphiFileTypeStrings[NodeObject1.DelphiFile.UnitInfo.DelphiFileType],
        DelphiFileTypeStrings[NodeObject2.DelphiFile.UnitInfo.DelphiFileType]);
    3:
      Result := CompareInteger(NodeObject1.DelphiFile.UnitInfo.LinesOfCode, NodeObject2.DelphiFile.UnitInfo.LinesOfCode);
    4:
      Result := CompareInteger(NodeObject1.DelphiFile.UsedCount, NodeObject2.DelphiFile.UsedCount);
    5:
      Result := CompareInteger(NodeObject1.DelphiFile.UnitInfo.UsedUnits.Count,
        NodeObject2.DelphiFile.UnitInfo.UsedUnits.Count);
    6:
      Result := 0;
    7:
      Result := CompareInteger(Integer(FTreeNodeObjects[GetID(Node1)].CircularReference),
        Integer(FTreeNodeObjects[GetID(Node2)].CircularReference));
    8:
      Result := CompareBoolean(FTreeNodeObjects[GetID(Node1)].Link <> nil, FTreeNodeObjects[GetID(Node2)].Link <> nil);
    9:
      Result := CompareStr(NodeObject1.DelphiFile.UnitInfo.Filename, NodeObject2.DelphiFile.UnitInfo.Filename);
    10:
      Result := CompareTwoModulesTreeNodes(NodeObject1.DelphiFile, NodeObject2.DelphiFile);
  end;

end;

procedure TfrmMain.vtUnitsTreeDblClick(Sender: TObject);
begin
  if vtUnitsTree.FocusedNode <> nil then
    vtUnitsTree.SelectNodeEx(GetLinkedNode(vtUnitsTree.FocusedNode));
end;

procedure TfrmMain.vtUnitsTreeFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  UpdateTreeControls(Node);
end;

procedure TfrmMain.vtUnitsTreeFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode;
  OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
begin
  if memParentFile.Modified then
    case MessageDlg(Format(StrSHasBeenModifi, [tabParentFile.Caption]), mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        memParentFile.Lines.SaveToFile(FTreeNodeObjects[GetID(OldNode.Parent)].DelphiFile.UnitInfo.Filename);
      mrCancel:
        begin
          Allowed := FALSE;

          Exit;
        end;
    end;

  if memSelectedFile.Modified then
    case MessageDlg(Format(StrSHasBeenModifi, [tabSelectedFile.Caption]), mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        memSelectedFile.Lines.SaveToFile(FTreeNodeObjects[GetID(OldNode)].DelphiFile.UnitInfo.Filename);
      mrCancel:
        Allowed := FALSE;
    end;
end;

procedure TfrmMain.UpdateTreeControls(Node: PVirtualNode);
var
  ParentFileInfo: IUnitInfo;
  UsedUnitInfo: IUsedUnitInfo;
  ParentFileNameToShow: string;
begin
  SetNodePathRichEdit(Node, RichEditUnitPath);

  tabParentFile.TabVisible := (Node <> nil) and (Node.Parent <> vtUnitsTree.RootNode);
  tabSelectedFile.TabVisible := (Node <> nil) and (FTreeNodeObjects[GetID(Node)].DelphiFile.InSearchPath);

  if Node <> nil then
  begin
    pcSource.Visible := TRUE;

    if (FTreeNodeObjects[GetID(Node)].DelphiFile.InSearchPath) and
      (FileExists(FTreeNodeObjects[GetID(Node)].DelphiFile.UnitInfo.Filename)) then
    begin
      tabSelectedFile.Caption := ExtractFileName(FTreeNodeObjects[GetID(Node)].DelphiFile.UnitInfo.Filename);
      memSelectedFile.Lines.LoadFromFile(FTreeNodeObjects[GetID(Node)].DelphiFile.UnitInfo.Filename);
      memSelectedFile.Modified := FALSE;
    end;

    if (Node.Parent <> vtUnitsTree.RootNode) and (FileExists(FTreeNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.Filename))
    then
    begin
      ParentFileInfo       := FTreeNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo;
      ParentFileNameToShow := ParentFileInfo.Filename;

      UsedUnitInfo := ParentFileInfo.UsedUnits[GetNodeIndex(Node)];

      if not UsedUnitInfo.IsInIncludeFileName.IsEmpty then
        ParentFileNameToShow := UsedUnitInfo.IsInIncludeFileName;

      tabParentFile.Caption := ExtractFileName(ParentFileNameToShow);
      memParentFile.Lines.LoadFromFile(ParentFileNameToShow);

      memParentFile.SelStart := UsedUnitInfo.Position;
      if UsedUnitInfo.InFilePosition > 0 then
      begin
        // memParentFile.SelStart  := UsedUnitInfo.InFilePosition; // uncomment this line to visualize unitname recognition in the "in file" part
      end;
      memParentFile.SelLength := Length(UsedUnitInfo.DelphiUnitName);

      memParentFile.Modified := FALSE;

      pcSource.ActivePageIndex := 0;
    end;
  end
  else
    pcSource.Visible := FALSE;
end;

function TfrmMain.GetNodePath(Node: PVirtualNode): String;
begin
  Result := '';

  while (Node <> nil) and (Node <> vtUnitsTree.RootNode) do
  begin
    if Result <> '' then
      Result := ' -> ' + Result;

    Result := FTreeNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName + Result;

    Node := Node.Parent;
  end;
end;

procedure TfrmMain.SetNodePathRichEdit(Node: PVirtualNode; ARichEdit: TRichEdit);
var
  LStartNodeFile: string;
  LParentNodeFile: string;
  LArrow: string;
begin
  ARichEdit.Clear;

  if Node <> nil then
    LStartNodeFile := FTreeNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName;

  LArrow := '';

  while (Node <> nil) and (Node <> vtUnitsTree.RootNode) do
  begin
    LParentNodeFile := FTreeNodeObjects[GetID(Node)].DelphiFile.UnitInfo.DelphiUnitName;

    RichEditUnitPath.SelStart := 0;

    if AnsiSameText(LStartNodeFile, LParentNodeFile) then
      RichEditUnitPath.SelAttributes.Style := [fsBold]
    else
      RichEditUnitPath.SelAttributes.Style := [];

    RichEditUnitPath.SelText := LParentNodeFile + LArrow;
    LArrow := ' -> ';

    Node := Node.Parent;
  end;
end;

procedure TfrmMain.vtUnitsTreeGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected]) and (Column = 0) then
  begin
    case FTreeNodeObjects[GetID(Node)].CircularReference of
      crNone:
        ImageIndex := 0;
      crSemiCircular:
        ImageIndex := 1;
      crCircular:
        ImageIndex := 2;
    end;
  end;
end;

procedure TfrmMain.vtUnitsTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TNodeData);
end;

function TfrmMain.GetLinkedNode(Node: PVirtualNode): PVirtualNode;
begin
  if Node = nil then
    Result := nil
  else
  begin
    Result := FTreeNodeObjects[GetID(Node)].Link;

    if Result = nil then
      Result := Node;
  end;
end;

function TfrmMain.GetNodeIndex(const Node: PVirtualNode): Integer;
var
  NodeData: PNodeData;
begin
  NodeData := Node.GetData;

  if Assigned(NodeData) then
  begin
    Result := NodeData.Index;
  end
  else
  begin
    raise Exception.Create('No node data found');
  end;
end;

procedure TfrmMain.vtUnitsTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  UnitInfo: IUnitInfo;
  DelphiFile: TDelphiFile;
  ParentUnitFilename: String;
begin
  DelphiFile := FTreeNodeObjects[GetID(Node)].DelphiFile;
  UnitInfo := DelphiFile.UnitInfo;

  if TextType = ttStatic then
  begin
    CellText := '';

    if (Node.Parent <> Sender.RootNode) and (Column = 0) and
      (GetNodeIndex(Node) < FTreeNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits.Count) then
    begin
      ParentUnitFilename := FTreeNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits[GetNodeIndex(Node)
        ].DelphiUnitName;

      if not SameText(ParentUnitFilename, UnitInfo.DelphiUnitName) then
        CellText := '(' + ParentUnitFilename + ')';
    end;
  end
  else
  begin
    CellText := '-';

    case Column of
      0:
        CellText := UnitInfo.DelphiUnitName;

      1:
        CellText := UnitInfo.PreviousUnitName;

      2:
        if DelphiFile.InSearchPath then
          CellText := DelphiFileTypeStrings[UnitInfo.DelphiFileType];

      3:
        if UnitInfo.LinesOfCode > 0 then
          CellText := IntToStr(UnitInfo.LinesOfCode);

      4:
        CellText := IntToStr(DelphiFile.UsedCount);

      5:
        if DelphiFile.UnitInfo.UsedUnits.Count > 0 then
          CellText := IntToStr(DelphiFile.UnitInfo.UsedUnits.Count);

      6:
        if (DelphiFile.InSearchPath) and (Sender.GetNodeLevel(Node) > 0) and (FTreeNodeObjects[GetID(Node)] <> nil) and
          (GetNodeIndex(Node) < FTreeNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits.Count) then
          CellText := UsesTypeStrings[FTreeNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.UsedUnits[GetNodeIndex(Node)
            ].UsesType];

      7:
        CellText := CircularRelationshipTypeDescriptions[FTreeNodeObjects[GetID(Node)].CircularReference];

      8:
        if FTreeNodeObjects[GetID(Node)].Link <> nil then
          CellText := StrYes
        else
          CellText := StrNo;

      9:
        CellText := UnitInfo.Filename;

      10:
        if Assigned(UnitInfo.Module) then
          CellText := UnitInfo.Module.Name;
    end;
  end;
end;

procedure TfrmMain.vtCommonHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
begin
  inherited;

  // Sort the list
  ShowHourGlass;
  try
    if Sender.SortColumn = HitInfo.Column then
    Begin
      if Sender.SortDirection = sdAscending then
        Sender.SortDirection := sdDescending
      else
        Sender.SortDirection := sdAscending;
    end
    else
    begin
      Sender.SortColumn := HitInfo.Column;
      Sender.SortDirection := sdAscending;
    end;

    Sender.Treeview.Sort(nil, Sender.SortColumn, Sender.SortDirection);

    Sender.Treeview.Invalidate;
  finally
    HideHourGlass;
  end;
end;

procedure TfrmMain.vtUnitsListDblClick(Sender: TObject);
begin
  if TVirtualStringTree(Sender).FocusedNode <> nil then
  begin
    pcView.ActivePage := tabTree;

    vtUnitsTree.SelectNodeEx(FModel.DelphiFileList[GetFocusedID(TVirtualStringTree(Sender))].BaseTreeNode);
    vtUnitsTree.SetFocus;
  end;
end;

procedure TfrmMain.vtUnitsListFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
begin
  UpdateListControls(Node);
end;

procedure TfrmMain.UpdateListControls(Node: PVirtualNode);
var
  DelphiFile: TDelphiFile;
begin
  pcList.Visible := vtUnitsList.FocusedNode <> nil;

  if Node <> nil then
  begin
    DelphiFile := FModel.DelphiFileList[GetFocusedID(vtUnitsList)];

    if (DelphiFile.InSearchPath) and (FileExists(DelphiFile.UnitInfo.Filename)) then
    begin
      memListFile.Lines.LoadFromFile(DelphiFile.UnitInfo.Filename);
      memListFile.Modified := FALSE;
    end;

    SearchUnitsListChildList(vtUsedByUnits, edtSearchUsedByList.Text, TRUE);
    SearchUnitsListChildList(vtUsesUnits, edtSearchUsesList.Text, FALSE);

    vtUsedByUnits.AutoFitColumns;
    vtUsesUnits.AutoFitColumns;
  end;
end;

procedure TfrmMain.vtUnitsListFocusChanging(Sender: TBaseVirtualTree; OldNode, NewNode: PVirtualNode;
  OldColumn, NewColumn: TColumnIndex; var Allowed: Boolean);
begin
  if memListFile.Modified then
    case MessageDlg(Format(StrSHasBeenModifi, [FModel.DelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.Filename]),
      mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        memListFile.Lines.SaveToFile(FModel.DelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.Filename);
      mrCancel:
        Allowed := FALSE;
    end;
end;

procedure TfrmMain.vtCommonGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: TImageIndex);
begin
  if (Kind in [ikNormal, ikSelected]) and (Column = 0) then
  begin
    ImageIndex := 0;
  end;
end;

procedure TfrmMain.vtUnitsListCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex;
  var Result: Integer);
var
  idx1, idx2: Integer;
  DelphiFile1, DelphiFile2: TDelphiFile;
begin
  idx1 := GetID(Node1);
  idx2 := GetID(Node2);

  if (idx1 <> -1) and (idx2 <> -1) then
  begin
    DelphiFile1 := FModel.DelphiFileList[idx1];
    DelphiFile2 := FModel.DelphiFileList[idx2];

    case Column of
      cvtUnitsList_ColumnIdx_Unit:
        Result := CompareStr(DelphiFile1.UnitInfo.DelphiUnitName, DelphiFile2.UnitInfo.DelphiUnitName);

      cvtUnitsList_ColumnIdx_FileType:
        Result := CompareStr(DelphiFileTypeStrings[DelphiFile1.UnitInfo.DelphiFileType],
          DelphiFileTypeStrings[DelphiFile2.UnitInfo.DelphiFileType]);

      cvtUnitsList_ColumnIdx_LoC:
        Result := CompareInteger(DelphiFile1.UnitInfo.LinesOfCode, DelphiFile2.UnitInfo.LinesOfCode);

      cvtUnitsList_ColumnIdx_UsedByUnits_Count:
        Result := CompareInteger(DelphiFile1.UsedCount, DelphiFile2.UsedCount);

      cvtUnitsList_ColumnIdx_UsedUnits_Count:
        Result := CompareInteger(DelphiFile1.UnitInfo.UsedUnits.Count, DelphiFile2.UnitInfo.UsedUnits.Count);

      cvtUnitsList_ColumnIdx_FileName:
        Result := CompareStr(DelphiFile1.UnitInfo.Filename, DelphiFile2.UnitInfo.Filename);

      cvtUnitsList_ColumnIdx_Module:
        Result := CompareTwoModulesTreeNodes(DelphiFile1, DelphiFile2);
    end;
  end;
end;

procedure TfrmMain.vtUnitsListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType; var CellText: string);
var
  UnitInfo: IUnitInfo;
  DelphiFile: TDelphiFile;
begin
  CellText := '-';

  DelphiFile := FModel.DelphiFileList[GetID(Node)];
  UnitInfo   := DelphiFile.UnitInfo;

  case Column of
    cvtUnitsList_ColumnIdx_Unit:
      CellText := UnitInfo.DelphiUnitName;

    cvtUnitsList_ColumnIdx_FileType:
      if DelphiFile.InSearchPath then
        CellText := DelphiFileTypeStrings[UnitInfo.DelphiFileType];

    cvtUnitsList_ColumnIdx_LoC:
      CellText := IntToStr(UnitInfo.LinesOfCode);

    cvtUnitsList_ColumnIdx_UsedByUnits_Count:
      CellText := IntToStr(DelphiFile.UsedCount);

    cvtUnitsList_ColumnIdx_UsedUnits_Count:
      CellText := IntToStr(DelphiFile.UnitInfo.UsedUnits.Count);

    cvtUnitsList_ColumnIdx_FileName:
      CellText := UnitInfo.Filename;

    cvtUnitsList_ColumnIdx_Module:
      if Assigned(UnitInfo.Module) then
        CellText := UnitInfo.Module.Name;
  end;
end;

procedure TfrmMain.vtUnitsListDrawText(Sender: TBaseVirtualTree;
    TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; const
    Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  aDelphiFile: TDelphiFile;
begin
  // highlight "unknown modules"
  if Column = cvtUnitsList_ColumnIdx_Module then
    if not Sender.Selected[Node] then
    begin
      aDelphiFile := FModel.DelphiFileList[GetID(Node)];
      if aDelphiFile.UnitInfo.Module = FModel.Modules.UnknownModule then
      begin
        TargetCanvas.Brush.Color := cUnknownModuleBackgroundColor;
        TargetCanvas.Font.Color  := cUnknownModuleForegroundColor;
      end;
    end;
end;

procedure TfrmMain.vtUnitsListPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
begin
  if (not Sender.Selected[Node]) and (not FModel.DelphiFileList[GetID(Node)].InSearchPath) then
    TargetCanvas.Font.Color := cNotInSearchpathForegroundColor;
end;

procedure TfrmMain.vtUnitsListSearchComparison(Sender: TObject; Node: PVirtualNode; const SearchTerms: TStrings;
  var IsMatch: Boolean);
var
  i: Integer;
begin
  IsMatch := TRUE;

  for i := 0 to pred(SearchTerms.Count) do
    if (pos(LowerCase(SearchTerms[i]), LowerCase(FModel.DelphiFileList[GetID(Node)].UnitInfo.DelphiUnitName)) = 0) or
      ((not actShowUnitsNotInPath.Checked) and (not FModel.DelphiFileList[GetID(Node)].InSearchPath)) then
    begin
      IsMatch := FALSE;

      Break;
    end;
end;

procedure TfrmMain.vtUnitsTreePaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType);
var
  aDelphiFile: TDelphiFile;
begin
  if TextType = ttStatic then
  begin
    if not Sender.Selected[Node] then
      TargetCanvas.Font.Color := clGray;
  end
  else
  begin
    aDelphiFile := FTreeNodeObjects[GetID(Node)].DelphiFile;
    if (Column = 0) and (Sender.FocusedNode = Node) and (IsSearchHitNode(Node)) then
      TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];

    if not Sender.Selected[Node] then
    begin
      if not aDelphiFile.InSearchPath then
        TargetCanvas.Font.Color := cNotInSearchpathForegroundColor
      else if FTreeNodeObjects[GetID(GetLinkedNode(Node))].DelphiFile.UnitInfo.DelphiFileType = ftUnknown then
        TargetCanvas.Font.Color := clRed;
    end;

    // highlight "linked" nodes
    if Column = 0 then
    begin
      if FTreeNodeObjects[GetID(Node)].Link <> nil then
      begin
        if not Sender.Selected[Node] then
        begin
          if aDelphiFile.InSearchPath then
            TargetCanvas.Font.Color := clBlue
          else
            TargetCanvas.Font.Color := $00FEC9B1;
        end;

        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsUnderline];
      end;
    end;
  end;
end;

procedure TfrmMain.vtUnitsTreeDrawText(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode;
  Column: TColumnIndex; const Text: string; const CellRect: TRect; var DefaultDraw: Boolean);
var
  aDelphiFile: TDelphiFile;
begin
  // highlight "unknown modules"
  if Column = 10 then // Column = 'Modules'
    if not Sender.Selected[Node] then
    begin
      aDelphiFile := FTreeNodeObjects[GetID(Node)].DelphiFile;
      if aDelphiFile.UnitInfo.Module = FModel.Modules.UnknownModule then
      begin
        TargetCanvas.Brush.Color := cUnknownModuleBackgroundColor;
        TargetCanvas.Font.Color  := cUnknownModuleForegroundColor;
      end;
    end;
end;

function TfrmMain.IsSearchHitNode(Node: PVirtualNode): Boolean;
var
  aUnitInfo: IUnitInfo;
begin
  Result := false;

  if Assigned(Node) then
  begin
    aUnitInfo := FTreeNodeObjects[GetID(Node)].DelphiFile.UnitInfo;
    Result :=    (Pos(FSearchText, LowerCase(aUnitInfo.DelphiUnitName)) > 0)
              or ((aUnitInfo.Module <> nil) and (Pos(FSearchText, LowerCase(aUnitInfo.Module.Name)) > 0));
  end;
end;

procedure TfrmMain.actCloseProjectExecute(Sender: TObject);
begin
  if (CheckNotRunning) and (CheckSaveProject) then
  begin
    FProjectFilename := '';

    ClearGUIAndModelAndCloseControls;
  end;
end;

procedure TfrmMain.actCollapseAllExecute(Sender: TObject);
begin
  vtUnitsTree.CollapseAll(nil);
end;

procedure TfrmMain.actCollapseExecute(Sender: TObject);
begin
  vtUnitsTree.Expanded[vtUnitsTree.FocusedNode] := FALSE;
end;

procedure TfrmMain.actExpandExecute(Sender: TObject);
begin
  vtUnitsTree.ExpandAll(vtUnitsTree.FocusedNode);
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actExpandAllExecute(Sender: TObject);
begin
  ExpandAll;
end;

procedure TfrmMain.ExpandAll;
begin
  vtUnitsTree.ExpandAll(nil);
  vtUnitsTree.AutoFitColumns;
end;

procedure TfrmMain.ActionManager1Update(Action: TBasicAction; var Handled: Boolean);
begin
  UpdateControls;

  Handled := TRUE;
end;

procedure TfrmMain.actSaveCircularRefsExecute(Sender: TObject);
var
  Node: PVirtualNode;
  LStrs: TStringList;
begin
  vtUnitsTree.BeginUpdate;
  LStrs := TStringList.Create;
  try
    LStrs.Add('Kind;Unit;Ref');
    Node := vtUnitsTree.GetFirst;

    while Node <> nil do
    begin
      if FTreeNodeObjects[GetID(Node)].DelphiFile.InSearchPath then
      begin
        if FTreeNodeObjects[GetID(Node)].CircularReference in [crSemiCircular, crCircular] then
        begin
          LStrs.Add(CircularRelationshipTypeDescriptions[FTreeNodeObjects[GetID(Node)].CircularReference] + ';' +
            FTreeNodeObjects[GetID(Node.Parent)].DelphiFile.UnitInfo.DelphiUnitName + ';' + FTreeNodeObjects[GetID(Node)
            ].DelphiFile.UnitInfo.DelphiUnitName);
        end;
      end;

      Node := vtUnitsTree.GetNext(Node);
    end;

    if vtUnitsTree.FocusedNode <> nil then
      vtUnitsTree.ScrollIntoView(vtUnitsTree.FocusedNode, TRUE);
  finally
    if saveDialog_Units_GephiCSV.Execute then
      LStrs.SaveToFile(saveDialog_Units_GephiCSV.Filename);
    LStrs.Free;
    vtUnitsTree.EndUpdate;
  end;
end;

procedure TfrmMain.UpdateControls;
var
  DelphiFile: TDelphiFile;
begin
  DelphiFile := GetFocusedDelphiFile;

  actShowUnitsNotInPath.Enabled := (not FBusy);
  actSaveChanges.Enabled := (not FBusy) and ((memParentFile.Modified) or (memSelectedFile.Modified) or
    (memListFile.Modified));

  actRename.Enabled := (not FBusy) and (DelphiFile <> nil) and (DelphiFile.InSearchPath);

  actApplyRenameList.Enabled := actRename.Enabled;
  actAddUnitToUses.Enabled := actRename.Enabled;

  actSearchAndReplace.Enabled := (not FBusy) and (vtUnitsTree.RootNodeCount > 0);

  actExpandAll.Enabled := (not FBusy) and (pcView.ActivePage = tabTree) and (vtUnitsTree.RootNodeCount > 0);
  actCollapseAll.Enabled := (not FBusy) and (pcView.ActivePage = tabTree) and (vtUnitsTree.RootNodeCount > 0);
  actExpand.Enabled := (not FBusy) and (vtUnitsTree.FocusedNode <> nil);
  actCollapse.Enabled := (not FBusy) and (vtUnitsTree.FocusedNode <> nil);
  actLoadProject.Enabled := not FBusy;
  actSaveProject.Enabled := (not FBusy) and (FProjectFilename <> '');
  actSaveProjectAs.Enabled := not FBusy;
  actSettings.Enabled := not FBusy;
  actCloseProject.Enabled := (pnlMain.Visible) or (FProjectFilename <> '');
  actShowFile.Enabled := DelphiFile <> nil;
  actSaveToXML.Enabled := not FBusy;
  actSaveToGephiCSV.Enabled := not FBusy;
  actSaveToGraphML.Enabled := not FBusy;
  actSaveCircularRefs.Enabled := not FBusy;
end;

procedure TfrmMain.actLoadProjectExecute(Sender: TObject);
begin
  if openDialog_Project.Execute and CheckSaveProject then
  begin
    if LoadProjectSettings(openDialog_Project.Filename) then
    begin
      FProjectFilename := openDialog_Project.Filename;

      SetFormCaption;
    end;
  end;
end;

procedure TfrmMain.actNewProjectExecute(Sender: TObject);
begin
  if CheckNotRunning and CheckSaveProject then
  begin
    FProjectFilename := '';

    ClearGUIAndModelAndCloseControls;

    ResetSettings;

    actSettings.Execute;
  end;
end;

procedure TfrmMain.ResetSettings;
begin
  FProjectFilename := '';
  FProjectSettings.RootFiles.Clear;
  FProjectSettings.SearchPaths.Clear;
  FProjectSettings.UnitScopeNames.Clear;
  FProjectSettings.LinkUnits := TRUE;
end;

function TfrmMain.CheckNotRunning: Boolean;
begin
  Result := not FBusy;

  if not Result then
    MessageDlg(StrPleaseStopTheCurr, mtInformation, [mbOK], 0);
end;

procedure TfrmMain.UpdateLogEntries;
begin
  vtLog.RootNodeCount := TDudsLogger.GetInstance.Count;
  vtLog.Invalidate;

  if not vtLog.Focused then
    vtLog.ScrollIntoView(vtLog.GetLast, FALSE);
end;

procedure TfrmMain.ClearGUIAndModelAndCloseControls;
begin
  vtUnitsTree.Clear;
  vtUnitsList.Clear;
  vtUsedByUnits.Clear;
  vtUsesUnits.Clear;
  vtStats.Clear;

  vtUnitsTree.Header.Columns[1].Options := vtUnitsTree.Header.Columns[1].Options - [coVisible];

  FModel.Clear;
  FStats.Clear;
  TDudsLogger.GetInstance.Clear;
  UpdateLogEntries;

  pnlMain.Visible := FALSE;

  SetFormCaption;
end;

procedure TfrmMain.SetFormCaption;
begin
  Caption := StrUnitDependencyScan;

  if FProjectFilename <> '' then
    Caption := Caption + ' - ' + ExtractFilenameNoExt(FProjectFilename);

  if Modified then
    Caption := Caption + '*';
end;

procedure TfrmMain.SetModified(const Value: Boolean);
begin
  FModified := Value;

  SetFormCaption;
end;

procedure TfrmMain.actRenameExecute(Sender: TObject);
begin
  RenameDelphiFileWithDialog(rtRename);
end;

procedure TfrmMain.actSearchAndReplaceExecute(Sender: TObject);
begin
  RenameDelphiFileWithDialog(rtSearchAndReplace);
end;

procedure TfrmMain.actApplyRenameListExecute(Sender: TObject);
var
  aFileName: String;
  ShowDlgResult: Boolean;
begin
  if (OpenDialogMultipleRenames.Execute) then
  begin
    aFileName := OpenDialogMultipleRenames.Filename;

    with TfrmRenameUnit.Create(Self) do
      try
        Width := Width + 300;
        Label1.Caption := 'Selected file';
        edtNewName.Text := aFileName;
        edtNewName.Enabled := FALSE;
        Caption := 'Rename multiple files';
        infoRenameCSV.Visible := TRUE;

        chkDummyRun.Checked := FEnvironmentSettings.DummyRun;
        chkRenameHistoryFiles.Checked := FEnvironmentSettings.RenameHistoryFiles;
        chkInsertOldNameComment.Checked := FEnvironmentSettings.RenameInsertOldNameComment;
        chkInsertOldNameComment.Caption := 'Insert "{renamed from ' + 'oldname' + '.pas} comment"';
        chkRenameLowerCaseExtension.Checked := FEnvironmentSettings.RenameLowerCaseExtension;

        ShowDlgResult := ShowModal = mrOK;

        if ShowDlgResult then
        begin

          FEnvironmentSettings.DummyRun := chkDummyRun.Checked;
          FEnvironmentSettings.RenameHistoryFiles := chkRenameHistoryFiles.Checked;
          FEnvironmentSettings.RenameInsertOldNameComment := chkInsertOldNameComment.Checked;
          FEnvironmentSettings.RenameLowerCaseExtension := chkRenameLowerCaseExtension.Checked;

          ApplyMultipleRenames(aFileName, chkDummyRun.Checked, chkRenameHistoryFiles.Checked,
            chkInsertOldNameComment.Checked, chkRenameLowerCaseExtension.Checked);
        end;
      finally
        Release;
      end;
  end;
end;

procedure TfrmMain.actAddUnitToUsesExecute(Sender: TObject);
var
  ShowDlgResult: Boolean;
  AddUnitToUsesRefactoring: TAddUnitToUsesRefactoring;
begin
  if GetFocusedDelphiFile <> nil then
  begin
    with TfrmAddNewUnit.Create(Self) do
      try
        edtNewName.Text := '';
        edtNewName.Enabled := TRUE;
        Label1.Caption := 'Add uses to all units that currently use "' +
          GetFocusedDelphiFile.UnitInfo.DelphiUnitName + '"';
        Caption := Label1.Caption;

        ShowDlgResult := ShowModal = mrOK;

        if ShowDlgResult then
        begin
          ClearLog();
          try
            AddUnitToUsesRefactoring := TAddUnitToUsesRefactoring.Create;
            try
              AddUnitToUsesRefactoring.Model := FModel;
              AddUnitToUsesRefactoring.AddUnitToUses(chkDummyRun.Checked, GetFocusedDelphiFile, edtNewName.Text, mem_OnlyApplyToUnits.Lines);

              // the refactoring changed the model, so we need to rebuild the gui from the model
              FillGUIFromModel;
              UpdateStats(TRUE);
            finally
              FreeAndNil(AddUnitToUsesRefactoring);
            end;
          finally
            UpdateLogEntries;
          end;
        end;

      finally
        Free;
      end;
  end;
end;

procedure TfrmMain.actFormatUsesOfFileExecute(Sender: TObject);
var
  aFormatUsesRefactoring : TFormatUsesRefactoring;
begin
  if GetFocusedDelphiFile <> nil then
  begin
      aFormatUsesRefactoring := TFormatUsesRefactoring.Create;
      try
        aFormatUsesRefactoring.Model    := FModel;
        aFormatUsesRefactoring.OnLog    := Self.Log;
        aFormatUsesRefactoring.DummyRun := false;
        aFormatUsesRefactoring.ProjectSettings := FProjectSettings;
        aFormatUsesRefactoring.AllowModuleGroupingWithUnknownModules := true;

        aFormatUsesRefactoring.FormatUsesInFile(GetFocusedDelphiFile.UnitInfo.DelphiUnitName);

      finally
        FreeAndNil(aFormatUsesRefactoring);
      end;
  end;
end;

procedure TfrmMain.actRemoveUnusedUnitsProcessPalOutputExecute(Sender: TObject);
begin
  try
    TPAUsesReportProcessor.ParseOutputFileAndWriteFiltered('./Uses.txt', './Unused.txt', './IgnoreUnits.txt');
  except
    on e: Exception do
      Log(e.Message, LogError);
  end;
end;

procedure TfrmMain.actRemoveUnUsedUnitsExecute(Sender: TObject);
var
  RemoveUnusedUnitsRefactoring: TRemoveUnusedUnitsRefactoring;
begin
  try
    RemoveUnusedUnitsRefactoring := TRemoveUnusedUnitsRefactoring.Create;
    try
      RemoveUnusedUnitsRefactoring.Model := FModel;
      RemoveUnusedUnitsRefactoring.OnLog := Self.Log;
      RemoveUnusedUnitsRefactoring.DeleteAllUnitsDefinedInUnusedFile('.\Unused.txt');
    finally
      FreeAndNil(RemoveUnusedUnitsRefactoring);
    end;
  except
    on e: Exception do
      Log(e.Message, LogError);
  end;
end;

function TfrmMain.GetFocusedDelphiFile: TDelphiFile;
begin
  if (vtUnitsTree.Focused) and (vtUnitsTree.FocusedNode <> nil) then
    Result := FTreeNodeObjects[GetID(vtUnitsTree.FocusedNode)].DelphiFile
  else

    if (vtUnitsList.Focused) and (vtUnitsList.FocusedNode <> nil) then
    Result := FModel.DelphiFileList[GetFocusedID(vtUnitsList)]
  else

    if (vtUsedByUnits.Focused) and (vtUsedByUnits.FocusedNode <> nil) then
    Result := FModel.DelphiFileList[GetFocusedID(vtUsedByUnits)]
  else

    if (vtUsesUnits.Focused) and (vtUsesUnits.FocusedNode <> nil) then
    Result := FModel.DelphiFileList[GetFocusedID(vtUsesUnits)]
  else
    Result := nil;
end;

function TfrmMain.RenameDelphiFileWithDialog(RenameType: TRenameType): Boolean;
begin
  Result := RenameDelphiFileWithDialog(GetFocusedDelphiFile, RenameType);
end;

function TfrmMain.RenameDelphiFileWithDialog(const DelphiFile: TDelphiFile; RenameType: TRenameType): Boolean;
begin
  Result := FALSE;

  case RenameType of
    rtRename:
      begin
        if DelphiFile <> nil then
        begin
          With TfrmRenameUnit.Create(Self) do
            try
              edtNewName.Text := DelphiFile.UnitInfo.DelphiUnitName;
              Caption := Format(StrRenameS, [edtNewName.Text]);

              chkDummyRun.Checked := FEnvironmentSettings.DummyRun;
              chkRenameHistoryFiles.Checked := FEnvironmentSettings.RenameHistoryFiles;
              chkInsertOldNameComment.Checked := FEnvironmentSettings.RenameInsertOldNameComment;
              chkInsertOldNameComment.Caption := 'Insert "{renamed from ' + DelphiFile.UnitInfo.DelphiUnitName +
                '.pas} comment"';
              chkRenameLowerCaseExtension.Checked := FEnvironmentSettings.RenameLowerCaseExtension;

              Result := ShowModal = mrOK;

              if Result then
              begin
                FEnvironmentSettings.DummyRun := chkDummyRun.Checked;
                FEnvironmentSettings.RenameHistoryFiles := chkRenameHistoryFiles.Checked;
                FEnvironmentSettings.RenameInsertOldNameComment := chkInsertOldNameComment.Checked;
                FEnvironmentSettings.RenameLowerCaseExtension := chkRenameLowerCaseExtension.Checked;

                RenameDelphiFile(TRUE, DelphiFile.UnitInfo.DelphiUnitName, edtNewName.Text,
                  chkDummyRun.Checked, chkRenameHistoryFiles.Checked, TRUE,
                  chkInsertOldNameComment.Checked, chkRenameLowerCaseExtension.Checked);
              end;
            finally
              Release;
            end;
        end;
      end;

    rtSearchAndReplace:
      begin
        With TfrmSearchAndReplace.Create(Self) do
          try
            if DelphiFile <> nil then
            begin
              edtSearch.Text := DelphiFile.UnitInfo.DelphiUnitName;
              edtReplace.Text := DelphiFile.UnitInfo.DelphiUnitName;
              edtTest.Text := DelphiFile.UnitInfo.DelphiUnitName;
            end;

            chkDummyRun.Checked := FEnvironmentSettings.DummyRun;
            chkRenameHistoryFiles.Checked := FEnvironmentSettings.RenameHistoryFiles;

            Result := ShowModal = mrOK;

            if Result then
            begin
              FEnvironmentSettings.DummyRun := chkDummyRun.Checked;
              FEnvironmentSettings.RenameHistoryFiles := chkRenameHistoryFiles.Checked;

              RenameDelphiFile(TRUE, edtSearch.Text, edtReplace.Text,
                chkDummyRun.Checked, chkRenameHistoryFiles.Checked, FALSE, FALSE, FALSE);
            end;
          finally
            Release;
          end;
      end;
  end;

  if Result then
    vtUnitsTree.Header.Columns[1].Options := vtUnitsTree.Header.Columns[1].Options + [coVisible];
end;

procedure TfrmMain.ApplyMultipleRenames(aCsvFilename: String; DummyRun, RenameHistoryFiles, InsertOldNameComment,
  RenameLowerCaseExtension: Boolean);
var
  aRenameFileStrings: TStringList;
  i: Integer;
  semicolonPos: Integer;
  aLine: String;
  OldUnitName, NewUnitName: String;
  renameCount: Integer;
  OldFile, NewFile: TDelphiFile;
  PreCheckOk: Boolean;
  aRenameUnitsList: TDictionary<String, String>;
begin

  aRenameUnitsList := TDictionary<String, String>.Create;
  try
    if FileExists(aCsvFilename) then
    begin
      ClearLog;

      PreCheckOk := TRUE;

      aRenameFileStrings := TStringList.Create;
      try
        aRenameFileStrings.LoadFromFile(aCsvFilename);
        for i := 0 to pred(aRenameFileStrings.Count) do
        begin
          aLine := aRenameFileStrings[i];
          semicolonPos := pos(';', aLine);
          OldUnitName := Copy(aLine, 1, semicolonPos - 1);
          NewUnitName := Copy(aLine, semicolonPos + 1, Length(aLine));

          // "old name" Unit exists?
          OldFile := FModel.FindParsedDelphiUnit(OldUnitName, nil);
          if not Assigned(OldFile) then
          begin
            Log(StrUnableToRenameS, [OldUnitName], LogError);
            PreCheckOk := FALSE;
          end;

          // "new name" unit does NOT exist already?
          NewFile := FModel.FindParsedDelphiUnit(NewUnitName, nil);
          if Assigned(NewFile) then
          begin
            Log(StrUnableToRenameToNewName, [OldUnitName, NewUnitName], LogError);
            PreCheckOk := FALSE;
          end;

          aRenameUnitsList.Add(OldUnitName, NewUnitName);
        end;
      finally
        FreeAndNil(aRenameFileStrings);
      end;

      renameCount := 0;
      if PreCheckOk then
      begin
        for OldUnitName in aRenameUnitsList.Keys do
        begin
          NewUnitName := aRenameUnitsList[OldUnitName];

          Log(StrStartBatchRename, [OldUnitName, NewUnitName], LogInfo);
          Application.ProcessMessages;

          RenameDelphiFile(FALSE, OldUnitName, NewUnitName, DummyRun, RenameHistoryFiles, TRUE,
            InsertOldNameComment, RenameLowerCaseExtension);
          Inc(renameCount);
        end;
      end;

      Log(StrBatchRenameResult, [renameCount], LogInfo);
    end
    else
      Log(StrUnableToFindFile, [aCsvFilename], LogWarning);
  finally
    FreeAndNil(aRenameUnitsList);
  end;
end;

procedure TfrmMain.RenameDelphiFile(const aClearLog: Boolean; const SearchString, ReplaceString: String;
  const DummyRun, RenameHistoryFiles, ExactMatch, InsertOldNameComment,
  LowerCaseExtension: Boolean);
var
  RenameRefactoring: TDudsRenameRefacotring;
begin
  if aClearLog then
    ClearLog();
  try
    RenameRefactoring := TDudsRenameRefacotring.Create;
    try
      RenameRefactoring.Model := FModel;
      RenameRefactoring.RenameDelphiFile(
        SearchString, ReplaceString,
        DummyRun, RenameHistoryFiles, ExactMatch,
        InsertOldNameComment, LowerCaseExtension);
    finally
      FreeAndNil(RenameRefactoring);
    end;
  finally
    UpdateLogEntries;
    UpdateTreeControls(vtUnitsTree.FocusedNode);
    UpdateListControls(vtUnitsList.FocusedNode);

    SearchList(vtUnitsList, edtListSearch.Text);

    vtUsedByUnits.Invalidate;
  end;
end;

procedure TfrmMain.ExportToXML(const VT: TVirtualStringTree; const Filename: String);
var
  XMLDoc: TXMLDocument;
  Count: Integer;

  procedure ProcessTreeItem(const ParentNode: PVirtualNode; const ParentXMLNode: IXMLNode);
  var
    Node: PVirtualNode;
    XMLNode: IXMLNode;
    NodeObject: TNodeObject;
    DelphiFile: TDelphiFile;
  begin
    if ParentNode <> nil then
    begin
      Node := ParentNode;

      while Node <> nil do
      begin
        if VT.IsVisible[Node] then
        begin
          DelphiFile := nil;

          if VT = vtUnitsList then
          begin
            DelphiFile := FModel.DelphiFileList[GetID(Node)];

            NodeObject := nil;
          end
          else
          begin
            NodeObject := FTreeNodeObjects[GetID(Node)];

            if NodeObject <> nil then
              DelphiFile := NodeObject.DelphiFile;
          end;

          if DelphiFile <> nil then
          begin
            XMLNode := ParentXMLNode.AddChild('Unit');
            XMLNode.Attributes['Name'] := DelphiFile.UnitInfo.DelphiUnitName;
            XMLNode.Attributes['UsedCount'] := DelphiFile.UsedCount.ToString;
            XMLNode.Attributes['InSearchPath'] := DelphiFile.InSearchPath;
            XMLNode.Attributes['LineCount'] := DelphiFile.UnitInfo.LinesOfCode;
            XMLNode.Attributes['UnitNameCharPosition'] := DelphiFile.UnitInfo.DelphiUnitNamePosition;
            XMLNode.Attributes['FileType'] := DelphiFileTypeStrings[DelphiFile.UnitInfo.DelphiFileType];

            if NodeObject <> nil then
            begin
              XMLNode.Attributes['IsLink'] := NodeObject.Link <> nil;
              XMLNode.Attributes['CircularReferenceType'] := CircularRelationshipTypeDescriptions
                [NodeObject.CircularReference];
            end;

            XMLNode.Attributes['Filename'] := DelphiFile.UnitInfo.Filename;

            Inc(Count);
          end;

          if Node.FirstChild <> nil then
            ProcessTreeItem(Node.FirstChild, XMLNode);
        end;

        Node := Node.NextSibling;
      end;
    end;
  end;

begin
  ShowHourGlass;
  try
    Count := 0;

    XMLDoc := TXMLDocument.Create(nil);

    XMLDoc.Active := TRUE;

    ProcessTreeItem(VT.GetFirst, XMLDoc.AddChild('DUDS'));

    XMLDoc.SaveToFile(Filename);
  finally
    HideHourGlass;
  end;
end;

procedure TfrmMain.FillGUIFromModel;

  function SearchForCircularRelationshipByWalkingUpParents(TreeNode: PVirtualNode; UsageType: TUsedUnitType; const DelphiUnitName: String): TCircularRelationshipType;
  var
    i: Integer;
  begin
    Result := crNone;

    TreeNode := TreeNode.Parent;

    if (TreeNode <> nil) and (TreeNode <> vtUnitsTree.RootNode) then
    begin
      while (TreeNode <> nil) and (TreeNode <> vtUnitsTree.RootNode) do
      begin
        if SameText(FTreeNodeObjects[GetID(TreeNode)].DelphiFile.UnitInfo.DelphiUnitName, DelphiUnitName) then
        begin
          if UsageType = utInterface then
            Result := crCircular
          else
            Result := crSemiCircular;

          Break;
        end
        else
          TreeNode := TreeNode.Parent;
      end;
    end;

  end;

  procedure AddTreeNode(Parent: PVirtualNode; UsageType: TUsedUnitType; UnitOrProjectFileName: string);
  var
    DelphiFile: TDelphiFile;
    NodeObject: TNodeObject;
    NodeObjectID: Cardinal;
    TreeNode: PVirtualNode;
    UsedUnitInfo: IUsedUnitInfo;
    UnitWasAddedForTheFirstTime: Boolean;
  begin
    DelphiFile := FModel.FindParsedDelphiUnit(UnitOrProjectFileName, FProjectSettings.UnitScopeNames);
    if Assigned(DelphiFile) then
    begin
      NodeObject              := TNodeObject.Create;
      NodeObject.DelphiFile   := DelphiFile;

      NodeObjectID := FTreeNodeObjects.Add(NodeObject);
      TreeNode     := vtUnitsTree.AddChild(Parent);
      SetID(TreeNode, NodeObjectID);

      // the first time we add a tree node for a unit, we remember that node to be the "base node"
      UnitWasAddedForTheFirstTime := not Assigned(DelphiFile.BaseTreeNode);
      if UnitWasAddedForTheFirstTime then
         DelphiFile.BaseTreeNode := TreeNode;

      // Calc Circular Ref by walking up the tree
      if Parent = nil then
         NodeObject.CircularReference := crNone
      else
         NodeObject.CircularReference := SearchForCircularRelationshipByWalkingUpParents(TreeNode, UsageType, DelphiFile.UnitInfo.DelphiUnitName);

      case NodeObject.CircularReference of
        crSemiCircular:
          Inc(FSemiCircularFiles);
        crCircular:
          Inc(FCircularFiles);
      end;

      // Recursively add used units as tree nodes
      // -> But add children of a unit only once in the tree. If the unit was already
      //    added, provide a "jump-link" to the first occurence. This keeps the tree smaller.
      if UnitWasAddedForTheFirstTime then
      begin
        if NodeObject.CircularReference = crNone then
          for UsedUnitInfo in DelphiFile.UnitInfo.UsedUnits do
            AddTreeNode(TreeNode, UsedUnitInfo.UsesType, UsedUnitInfo.DelphiUnitName)
      end
      else
        // when the unit occurs for the second, third, ... time, just link back to the "base node"
        if FProjectSettings.LinkUnits then
          NodeObject.Link := DelphiFile.BaseTreeNode;

      SetNodeVisibility(vtUnitsTree, TreeNode, DelphiFile);
    end;
  end;

  procedure FillTreeAndCalcCircularReferences;
  var
    DelphiFile, RootFile: TDelphiFile;
  begin
    // Reset stats
    FSemiCircularFiles := 0;
    FCircularFiles     := 0;

    // Reset "Base Nodes" (to be able to re-run this method without re-building the model
    for DelphiFile in FModel.DelphiFileList do
      DelphiFile.BaseTreeNode := nil;

    // Add root nodes to the tree and then recursively...
    for RootFile in FModel.ParsedDelphiRootFiles do
      AddTreeNode(nil, utInterface, RootFile.UnitInfo.DelphiUnitName);
  end;

  procedure FillLists;
  var
    Node: PVirtualNode;
    i: Integer;
  begin
    for i := 0 to pred(FModel.DelphiFileList.Count) do
    begin

      Node := vtUnitsList.AddChild(nil);
      SetID(Node, i);

      SetNodeVisibility(vtUnitsList, Node, FModel.DelphiFileList[i]);

      Node := vtUsedByUnits.AddChild(nil);
      SetID(Node, i);

      Node := vtUsesUnits.AddChild(nil);
      SetID(Node, i);
    end;

  end;

  procedure FillModules;
  var
    Node: PVirtualNode;
    module: TModule;
  begin
    for module in fModel.Modules.OrderedModules do
    begin
      Node := vtModules.AddChild(nil);
      SetID(Node, module.ID);
    end;
  end;

begin
  vtUnitsTree.Clear;
  vtUnitsList.Clear;
  vtUsedByUnits.Clear;
  vtUsesUnits.Clear;
  vtModules.Clear;
  memParentFile.Clear;
  memSelectedFile.Clear;

  Log(StrTransferingToGUI);

  vtUnitsTree.BeginUpdate;
  vtUnitsList.BeginUpdate;
  vtUsedByUnits.BeginUpdate;
  vtUsesUnits.BeginUpdate;
  vtModules.BeginUpdate;
  try
    FillTreeAndCalcCircularReferences;
    FillLists;
    FillModules;

    if vtUnitsTree.FocusedNode = nil then
      vtUnitsTree.SelectNodeEx(vtUnitsTree.GetFirst);

    if vtUnitsList.FocusedNode = nil then
      vtUnitsList.SelectNodeEx(vtUnitsList.GetFirst);
  finally
    vtUnitsTree.AutoFitColumns;
    vtUnitsList.AutoFitColumns;
    vtModules.AutoFitColumns;

    vtUnitsTree.EndUpdate;
    vtUnitsList.EndUpdate;
    vtUsedByUnits.EndUpdate;
    vtUsesUnits.EndUpdate;
    vtModules.EndUpdate;

    UpdateListControls(vtUnitsList.FocusedNode);
  end;
end;

procedure TfrmMain.actStartScanExecute(Sender: TObject);
var
  FileScanner: TDudsFileScanner;

  aUnitsTotal: integer;
  aUnitsInModules: integer;
begin
  if FProjectSettings.RootFiles.Count = 0 then
  begin
    if MessageDlg(StrYouNeedToAddAtLeastOne, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      actSettings.Execute
  end
  else
  begin
    ClearGUIAndModelAndCloseControls;
    FStartTime := now;
    FCancelled := FALSE;

    actStartScan.Visible := FALSE;
    actStopScan.Visible := TRUE;
    actStopScan.Enabled := TRUE;

    FBusy := TRUE;
    try
      UpdateControls;
      ShowHideControls;
      pnlMain.Visible := TRUE;

      RichEditUnitPath.Clear;
      RichEditUnitPath.SelText := 'Loading...';
      UpdateStats(TRUE);
      Refresh;

      // step 1: read modules definition (if defined)
      if not FProjectSettings.ModulesDefinitionFile.IsEmpty then
      begin
        TModulesSerializer.ReadFromJsonFile(FProjectSettings.ModulesDefinitionFile, FModel.Modules);
        Log(StrModulesDefinitionLoaded, [FModel.Modules.Dictionary.Count]);
      end;

      // step 2: scanning the disk for files (rootfiles & search paths)
      FileScanner := TDudsFileScanner.Create;
      try
        FileScanner.LoadFilesInSearchPaths(FModel, FProjectSettings);
        Log(StrDFilesFound, [FormatCardinal(FModel.Files.Count)]);
      finally
        FreeAndNil(FileScanner);
      end;

      // step 3: recursively parsing the root files for all used units
      if not FCancelled then
      begin
        FDependencyAnalyzer := TDudsDependencyAnalyzer.Create;
        try
          FDependencyAnalyzer.Model           := FModel;
          FDependencyAnalyzer.OnLog           := Self.Log;
          FDependencyAnalyzer.ProjectSettings := FProjectSettings;
          FDependencyAnalyzer.ScanRootFilesAndBuildUsesLists;

          FParsedFileCount   := FDependencyAnalyzer.ParsedFileCount;
          FScannedUsesCount  := FDependencyAnalyzer.ScannedUsesCount;
          FDeepestScanDepth  := FDependencyAnalyzer.DeepestScanDepth;
          FFMXFormCount      := FDependencyAnalyzer.FMXFormCount;
          FVCLFormCount      := FDependencyAnalyzer.VCLFormCount;
          FLineCount         := FDependencyAnalyzer.LinesOfCode;
          FSemiCircularFiles := FDependencyAnalyzer.SemiCircularFiles;
          FCircularFiles     := FDependencyAnalyzer.CircularFiles;
          FFilesNotInPath    := FDependencyAnalyzer.FilesNotInPath;
        finally
          FreeAndNil(FDependencyAnalyzer);
        end;
      end;

      // step 4: Identify modules for each .pas unit
      //   at this point, all unit that were "seen" (by root files, search paths
      //   or parsing units) are identified
      TModulesAnalyzer.MapUnitsToModules(FModel, aUnitsTotal, aUnitsInModules);
      Log(StrModulesIdentified, [FormatCardinal(aUnitsInModules), FormatCardinal(aUnitsTotal)]);

      // step 5: fill gui trees with data
      if not FCancelled then
        FillGUIFromModel;
    finally
      FBusy := FALSE;

      actStartScan.Visible := TRUE;
      actStopScan.Visible := FALSE;

      ShowHideControls;
      UpdateLogEntries;

      UpdateStats(TRUE);
      UpdateTreeControls(vtUnitsTree.FocusedNode);
    end;
  end;
end;

procedure TfrmMain.ShowHideControls;
begin
  pcView.Visible := not FBusy;
  Splitter1.Visible := not FBusy;

  if FBusy then
  begin
    FpnlLogHeight := pnlLog.Height;
    pnlLog.Align := alClient;
  end
  else
  begin
    pnlLog.Align := alBottom;
    pnlLog.Height := FpnlLogHeight;
    Splitter1.Top := pnlLog.Top - 1;
  end;
end;

procedure TfrmMain.actStopScanExecute(Sender: TObject);
begin
  FCancelled := TRUE;
  if Assigned(FDependencyAnalyzer) then
     FDependencyAnalyzer.Cancelled := FCancelled;

  actStopScan.Enabled := FALSE;
end;

procedure TfrmMain.actSaveChangesExecute(Sender: TObject);
begin
  if memParentFile.Modified then
    memParentFile.Lines.SaveToFile(FTreeNodeObjects[GetID(vtUnitsTree.FocusedNode.Parent)].DelphiFile.UnitInfo.Filename);

  if memSelectedFile.Modified then
    memSelectedFile.Lines.SaveToFile(FTreeNodeObjects[GetID(vtUnitsTree.FocusedNode.Parent)].DelphiFile.UnitInfo.Filename);

  if memListFile.Modified then
    memListFile.Lines.SaveToFile(FModel.DelphiFileList[GetFocusedID(vtUnitsList)].UnitInfo.Filename);

  memParentFile.Modified := FALSE;
  memSelectedFile.Modified := FALSE;
  memListFile.Modified := FALSE;
end;

procedure TfrmMain.actSaveProjectAsExecute(Sender: TObject);
begin
  SaveProjectAs;
end;

procedure TfrmMain.actSaveProjectExecute(Sender: TObject);
begin
  SaveProject;
end;

procedure TfrmMain.actSaveToGephiCSVExecute(Sender: TObject);
begin
  saveDialog_Units_GephiCSV.FileName := ChangeFileExt(FProjectFilename, '.units.gephi.csv');

  if saveDialog_Units_GephiCSV.Execute then
    ExportToGephi(FModel, actShowUnitsNotInPath.Checked, saveDialog_Units_GephiCSV.Filename);
end;

procedure TfrmMain.actSaveToGraphMLExecute(Sender: TObject);
begin
  saveDialog_Units_GraphML.FileName := ChangeFileExt(FProjectFilename, '.units.graphml');

  if saveDialog_Units_GraphML.Execute then
    ExportToGraphML(FModel, actShowUnitsNotInPath.Checked, saveDialog_Units_GraphML.Filename);
end;

procedure TfrmMain.actSaveToXMLExecute(Sender: TObject);
begin
  saveDialog_Units_XML.FileName := ChangeFileExt(FProjectFilename, '.units.xml');

  if saveDialog_Units_XML.Execute then
  begin
    if pcView.ActivePage = tabTree then
      ExportToXML(vtUnitsTree, saveDialog_Units_XML.Filename)
    else
      ExportToXML(vtUnitsList, saveDialog_Units_XML.Filename)
  end;
end;

procedure TfrmMain.actExportModulesToCSVExecute(Sender: TObject);
var
  aExportModulesToCSV: TExportModulesToCSV;
begin
  saveDialog_Modules_CSV.FileName := ChangeFileExt(FProjectFilename, '.modules.csv');

  if saveDialog_Modules_CSV.Execute then
  begin
    aExportModulesToCSV := TExportModulesToCSV.Create;
    try
      aExportModulesToCSV.Model           := FModel;
      aExportModulesToCSV.OnLog           := Self.Log;;
      aExportModulesToCSV.ProjectSettings := FProjectSettings;
      aExportModulesToCSV.FileName        := saveDialog_Modules_CSV.FileName;

      aExportModulesToCSV.ExportModules;
    finally
      aExportModulesToCSV.Free;
    end;
  end;
end;

procedure TfrmMain.actExportModulesToGraphMLExecute(Sender: TObject);
var
  aExportModulesToGraphML: TExportModulesToGraphML;
begin
  saveDialog_Modules_GraphML.FileName := ChangeFileExt(FProjectFilename, '.modules.graphml');

  if saveDialog_Modules_GraphML.Execute then
  begin
    aExportModulesToGraphML := TExportModulesToGraphML.Create;
    try
      aExportModulesToGraphML.Model           := FModel;
      aExportModulesToGraphML.OnLog           := Self.Log;;
      aExportModulesToGraphML.ProjectSettings := FProjectSettings;
      aExportModulesToGraphML.FileName        := saveDialog_Modules_GraphML.FileName;

      aExportModulesToGraphML.ExportModules;
    finally
      aExportModulesToGraphML.Free;
    end;
  end;
end;

function TfrmMain.SaveProject: Boolean;
begin
  if FProjectFilename = '' then
    Result := SaveProjectAs
  else
  begin
    SaveProjectSettings(FProjectFilename);

    Result := TRUE;
  end;
end;

function TfrmMain.SaveProjectAs: Boolean;
begin
  Result := saveDialog_Project.Execute;

  if Result then
  begin
    FProjectFilename := saveDialog_Project.Filename;

    SaveProjectSettings(FProjectFilename);
  end;
end;

procedure TfrmMain.actSettingsExecute(Sender: TObject);
begin
  With TfrmDependencyScannerSetting.Create(Self) do
    try
      SaveProjectSettings;

      if Execute(FEnvironmentSettings, FProjectSettings) then
      begin
        LoadProjectSettings('', FALSE);

        Modified := TRUE;
      end;
    finally
      Release;
    end;
end;

procedure TfrmMain.actShowFileExecute(Sender: TObject);
var
  DelphiFile: TDelphiFile;
begin
  DelphiFile := GetFocusedDelphiFile;

  if DelphiFile <> nil then
    ShellExecute(Handle, 'OPEN', PChar('explorer.exe'), PChar('/select, "' + DelphiFile.UnitInfo.Filename + '"'), nil,
      SW_NORMAL);
end;

procedure TfrmMain.actShowUnitsNotInPathExecute(Sender: TObject);
begin
  ShowUnitsNotInPath;
end;

procedure TfrmMain.SetNodeVisibility(VT: TVirtualStringTree; Node: PVirtualNode; DelphiFile: TDelphiFile);
begin
  if (Node <> nil) and (DelphiFile <> nil) then
    VT.IsVisible[Node] := (DelphiFile.InSearchPath) or
      ((not DelphiFile.InSearchPath) and (actShowUnitsNotInPath.Checked));
end;

procedure TfrmMain.ShowUnitsNotInPath; // TODO: This seems to be doubled logic, compare with Search-Methods for tree and list...
var
  Node: PVirtualNode;
begin
  vtUnitsTree.BeginUpdate;
  try
    Node := vtUnitsTree.GetFirst;

    while Node <> nil do
    begin
      SetNodeVisibility(vtUnitsTree, Node, FTreeNodeObjects[GetID(Node)].DelphiFile);

      Node := vtUnitsTree.GetNext(Node);
    end;

    if vtUnitsTree.FocusedNode <> nil then
      vtUnitsTree.ScrollIntoView(vtUnitsTree.FocusedNode, TRUE);
  finally
    vtUnitsTree.EndUpdate;
  end;

  vtUnitsList.BeginUpdate;
  try
    Node := vtUnitsList.GetFirst;

    while Node <> nil do
    begin
      SetNodeVisibility(vtUnitsList, Node, FModel.DelphiFileList[GetID(Node)]);

      Node := Node.NextSibling;
    end;

    if vtUnitsList.FocusedNode <> nil then
      vtUnitsList.ScrollIntoView(vtUnitsList.FocusedNode, TRUE);
  finally
    vtUnitsList.EndUpdate;
  end;
end;

procedure TfrmMain.tmrCloseTimer(Sender: TObject);
begin
  tmrClose.Enabled := FALSE;

  if not FBusy then
  begin
    FClosing := TRUE;

    Close;
  end;
end;

procedure TfrmMain.tmrLoadedTimer(Sender: TObject);
begin
  tmrLoaded.Enabled := FALSE;

  if FLoadLastProject then
    if not LoadProjectSettings(FProjectFilename) then
    begin
      FProjectFilename := '';
      ClearGUIAndModelAndCloseControls;
    end;

  Show;
end;

procedure TfrmMain.FixDPI;

  procedure ScaleVT(const VT: TVirtualStringTree);
  begin
    VT.DefaultNodeHeight := ScaleDimension(VT.DefaultNodeHeight, PixelsPerInch);
    VT.Header.Height    := ScaleDimension(VT.Header.Height, PixelsPerInch);
  end;

begin
  ScaleVT(vtUnitsTree);
  ScaleVT(vtUnitsList);
  ScaleVT(vtUsedByUnits);
  ScaleVT(vtUsesUnits);
  ScaleVT(vtModules);

  RichEditUnitPath.Height := ScaleDimension(RichEditUnitPath.Height, PixelsPerInch);
end;

procedure TfrmMain.ClearStats;
begin
  FScannedUsesCount := 0;
  FSemiCircularFiles := 0;
  FCircularFiles := 0;
  FParsedFileCount := 0;
  FLineCount := 0;
  FDeepestScanDepth := 0;
  FScanDepth := 0;
  FFMXFormCount := 0;
  FVCLFormCount := 0;
  FFilesNotInPath := 0;
end;

procedure TfrmMain.UpdateStats(ForceUpdate: Boolean);

var
  Index: Integer;

  procedure AddStat(const StatName: String; StatValue: Variant);
  begin
    if Index > FStats.Count - 1 then
      FStats.Add('');

    FStats[Index] := StatName + '=' + VarToStr(StatValue);

    Inc(Index);
  end;

begin
  if (not(FClosing)) and ((ForceUpdate) or (FNextStatusUpdate = 0) or (now > FNextStatusUpdate)) then
  begin
    FNextStatusUpdate := now + (50 * OneMilliSecond);

    Index := 0;

    AddStat(StrTime, SecondsToTimeString(SecondsBetween(now, FStartTime)));
    AddStat(StrSearchPathFiles, FormatCardinal(FModel.Files.Count));
    AddStat(StrScannedUsesCount, FormatCardinal(FScannedUsesCount));

    AddStat(StrFilesFound, FormatCardinal(FModel.ParsedDelphiFiles.Count));
    AddStat(StrNotInSearchPathFiles, FormatCardinal(FFilesNotInPath));
    AddStat(StrParsedFiles, FormatCardinal(FParsedFileCount));

    AddStat(StrSemiCircularFiles, FormatCardinal(FSemiCircularFiles));
    AddStat(StrFCircularFiles, FormatCardinal(FCircularFiles));

    AddStat(StrVCLFormCount, FormatCardinal(FVCLFormCount));
    AddStat(StrFMXFormCount, FormatCardinal(FFMXFormCount));
    AddStat(StrTotalLines, FormatCardinal(FLineCount));
    AddStat(StrDeepestScanDepth, FDeepestScanDepth);

    if FBusy then
    begin
      AddStat(StrScanDepth, FScanDepth);
    end;

    while Index < FStats.Count do
      FStats.Delete(pred(FStats.Count));

    vtStats.RootNodeCount := FStats.Count;
    vtStats.Invalidate;
  end;
end;

procedure TfrmMain.vtModulesGetText(Sender: TBaseVirtualTree; Node:
    PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText:
    string);
var
  aModule: TModule;
begin
  aModule := fModel.Modules.OrderedModules[GetID(Node) - 1]; // ID beginnt mit 1, ObjectList mit 0

  CellText := '';

  if TextType <> ttStatic then
  begin

    case Column of
      0:
        CellText := aModule.Name;
      1:
        if aModule.Origin <> moUndefined then
          CellText := TModulesSerializer.cModuleOriginJSONEnumValues[aModule.Origin];
      2:
        if aModule.Usage <> muUndefined then
          CellText := TModulesSerializer.cModuleUsageJSONEnumValues[aModule.Usage];

      3:
        if aModule.AnalysisData.NumberOfFiles > 0 then
          CellText := FormatCardinal(aModule.AnalysisData.NumberOfFiles);

      4:
        if aModule.AnalysisData.NumberOfFilesNotInPath > 0 then
          CellText := FormatCardinal(aModule.AnalysisData.NumberOfFilesNotInPath);

      5:
        if aModule.AnalysisData.LinesOfCode > 0 then
          CellText := FormatCardinal(aModule.AnalysisData.LinesOfCode);
    end;
  end;
end;

procedure TfrmMain.vtModulesDrawText(Sender: TBaseVirtualTree; TargetCanvas:
    TCanvas; Node: PVirtualNode; Column: TColumnIndex; const Text: string;
    const CellRect: TRect; var DefaultDraw: Boolean);
var
  aModule: TModule;
begin
  aModule := fModel.Modules.OrderedModules[GetID(Node) - 1]; // ID beginnt mit 1, ObjectList mit 0

  // highlight "unknown modules"
  if Column = 0 then // Column = 'name'
    if not Sender.Selected[Node] then
    begin
      if aModule = FModel.Modules.UnknownModule then
      begin
        TargetCanvas.Brush.Color := cUnknownModuleBackgroundColor;
        TargetCanvas.Font.Color  := cUnknownModuleForegroundColor;
      end;
    end;
end;

end.
