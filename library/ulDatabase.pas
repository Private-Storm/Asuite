{
Copyright (C) 2006-2009 Matteo Salvi and Shannara

Website: http://www.salvadorsoftware.com/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
}

unit ulDatabase;

interface

uses
  Windows, SysUtils, Forms, Dialogs, VirtualTrees, ulNodeDataTypes, ulEnumerations,
  ulCommonClasses, Classes, mORMot, SynCommons, mORMotSQLite3,
  System.UITypes, Vcl.Controls;

type

  { TSQLVersion }

  TSQLtbl_version = class(TSQLRecord) //Table tbl_version
  private
    FMajor   : Integer;
    FMinor   : Integer;
    FRelease : Integer;
    FBuild   : Integer;
  published
    //property FIELDNAME: TYPE read FFIELDNAME write FFIELDNAME;
    property Major   : Integer read FMajor write FMajor;
    property Minor   : Integer read FMinor write FMinor;
    property Release : Integer read FRelease write FRelease;
    property Build   : Integer read FBuild write FBuild;
  end;

  { TSQLFiles }

  TSQLtbl_files = class(TSQLRecord) //Table tbl_files
  private
    Ftype             : Integer;
    Fparent           : Integer;
    Fposition         : Integer;
    Ftitle            : RawUTF8;
    Fpath             : RawUTF8;
    Fwork_path        : RawUTF8;
    Fparameters       : RawUTF8;
    FdateAdded        : Integer;
    FlastModified     : Integer;
    FlastAccess       : Integer;
    Fclicks           : Integer;
    Fno_mru           : Boolean;
    Fno_mfu           : Boolean;
    Fhide_from_menu   : Boolean;
    Fdsk_shortcut     : Boolean;
    Ficon             : RawUTF8;
    Fcacheicon_id     : Integer;
    Fonlaunch         : Integer;
    Fwindow_state     : Integer;
    Fautorun          : Integer;
    Fautorun_position : Integer;
  published
    //property FIELDNAME: TYPE read FFIELDNAME write FFIELDNAME;
    property itemtype: Integer read Ftype write Ftype;
    property parent: Integer read Fparent write Fparent;
    property position: Integer read Fposition write Fposition;
    property title: RawUTF8 read Ftitle write Ftitle;
    property path: RawUTF8 read Fpath write Fpath;
    property work_path: RawUTF8 read Fwork_path write Fwork_path;
    property parameters: RawUTF8 read Fparameters write Fparameters;
    property dateAdded: Integer read FdateAdded write FdateAdded;
    property lastModified: Integer read FlastModified write FlastModified;
    property lastAccess: Integer read FlastAccess write FlastAccess;
    property clicks: Integer read Fclicks write Fclicks;
    property no_mru: Boolean read Fno_mru write Fno_mru;
    property no_mfu: Boolean read Fno_mfu write Fno_mfu;
    property hide_from_menu: Boolean read Fhide_from_menu write Fhide_from_menu;
    property dsk_shortcut: Boolean read Fdsk_shortcut write Fdsk_shortcut;
    property icon_path: RawUTF8 read Ficon write Ficon;
    property cacheicon_id: Integer read Fcacheicon_id write Fcacheicon_id;
    property onlaunch: Integer read Fonlaunch write Fonlaunch;
    property window_state: Integer read Fwindow_state write Fwindow_state;
    property autorun: Integer read Fautorun write Fautorun;
    property autorun_position: Integer read Fautorun_position write Fautorun_position;
  end;

  TSQLtbl_options = class(TSQLRecord)
  private
    //General
    FStartWithWindows   : Boolean;
    FShowPanelAtStartUp : Boolean;
    FShowMenuAtStartUp  : Boolean;
    //Main Form
    FLanguage           : RawUTF8; { TODO -oMatteo -c : Language code (type RawUTF8?) 01/12/2009 23:02:23 }
    FUseCustomTitle     : Boolean;
    FCustomTitleString  : RawUTF8;
    FHideTabSearch      : Boolean;
    //Main Form - Position and size
    FHoldSize           : Boolean;
    FAlwaysOnTop        : Boolean;
    FListFormTop        : Integer;
    FListFormLeft       : Integer;
    FListFormWidth      : Integer;
    FListFormHeight     : Integer;
    //Main Form - Treevew
    FTVBackground       : Boolean;
    FTVBackgroundPath   : RawUTF8;
    FTVAutoOpClCats     : Boolean; //Automatic Opening/closing categories
    FTVFont             : RawUTF8;
    //MRU
    FMRU                : Boolean;
    FSubMenuMRU         : Boolean;
    FMRUNumber          : Integer;
    //MFU
    FMFU                : Boolean;
    FSubMenuMFU         : Boolean;
    FMFUNumber          : Integer;
    //Backup
    FBackup             : Boolean;
    FBackupNumber       : Integer;
    //Other functions
    FAutorun            : Boolean;
    FCache              : Boolean;
    //Execution
    FActionOnExe        : TActionOnExecution;
    FRunSingleClick     : Boolean;
    //Trayicon
    FTrayIcon           : Boolean;
    FTrayUseCustomIcon  : Boolean;
    FTrayCustomIconPath : RawUTF8;
    FActionClickLeft    : Integer;
    FActionClickRight   : Integer;
    //Mouse Sensors
    FSensorLeftClick    : RawUTF8; //0 Top, 1 Left, 2 Right, 3 Bottom
    FSensorRightClick   : RawUTF8;
  published
    //property FIELDNAME: TYPE read FFIELDNAME write FFIELDNAME;
    //General
    property startwithwindows: Boolean read FStartWithWindows write FStartWithWindows;
    property showpanelatstartup: Boolean read FShowPanelAtStartUp write FShowPanelAtStartUp;
    property showmenuatstartup: Boolean read FShowMenuAtStartUp write FShowMenuAtStartUp;
    // Main Form
    property language: RawUTF8 read FLanguage write FLanguage;
    property usecustomtitle: Boolean read FUseCustomTitle write FUseCustomTitle;
    property customtitlestring : RawUTF8 read FCustomTitleString write FCustomTitleString;
    property hidetabsearch: Boolean read FHideTabSearch write FHideTabSearch;
    // Main Form - Position and size
    property holdsize: Boolean read FHoldSize write FHoldSize;
    property alwaysontop: Boolean read FAlwaysOnTop write FAlwaysOnTop;
    property listformtop: Integer read FListFormTop write FListFormTop;
    property listformleft: Integer read FListFormLeft write FListFormLeft;
    property listformwidth: Integer read FListFormWidth write FListFormWidth;
    property listformheight: Integer read FListFormHeight write FListFormHeight;
    // Main Form - Treevew
    property tvbackground: Boolean read FTVBackground write FTVBackground;
    property tvbackgroundpath: RawUTF8 read FTVBackgroundPath write FTVBackgroundPath;
    property tvautoopclcats: Boolean read FTVAutoOpClCats write FTVAutoOpClCats;
    property tvfont: RawUTF8 read FTVFont write FTVFont;
    // MRU
    property mru: Boolean read FMRU write FMRU;
    property submenumru: Boolean read FSubMenuMRU write FSubMenuMRU;
    property mrunumber: Integer read FMRUNumber write FMRUNumber;
    // MFU
    property mfu: Boolean read FMFU write FMFU;
    property submenumfu: Boolean read FSubMenuMFU write FSubMenuMFU;
    property mfunumber: Integer read FMFUNumber write FMFUNumber;
    // Backup
    property backup: Boolean read FBackup write FBackup;
    property backupnumber: Integer read FBackupNumber write FBackupNumber;
    // Other functions
    property autorun: Boolean read FAutorun write FAutorun;
    property cache: Boolean read FCache write FCache;
    // Execution
    property actiononexe: TActionOnExecution read FActionOnExe write FActionOnExe;
    property runsingleclick: Boolean read FRunSingleClick write FRunSingleClick;
    // Trayicon
    property trayicon: Boolean read FTrayIcon write FTrayIcon;
    property trayusecustomicon: Boolean read FTrayUseCustomIcon write FTrayUseCustomIcon;
    property traycustomiconpath: RawUTF8 read FTrayCustomIconPath write FTrayCustomIconPath;
    property actionclickleft: Integer read FActionClickLeft write FActionClickLeft;
    property actionclickright: Integer read FActionClickRight write FActionClickRight;
    //Mouse Sensor
    property mousesensorleft:RawUTF8 read FSensorLeftClick write FSensorLeftClick;
    property mousesensorright:RawUTF8 read FSensorRightClick write FSensorRightClick;
  end;

  { TDBManager }

  TDBManager = class
  private
    FDBFileName : string;
    FDatabase   : TSQLRest;
    FSQLModel   : TSQLModel;
    FDBVersion  : TVersionInfo;
    FASuiteVersion : TVersionInfo;
    procedure InternalLoadVersion;
    procedure InternalLoadData(Tree: TBaseVirtualTree);
    procedure InternalLoadListItems(Tree: TBaseVirtualTree; ID: Integer;
                            ParentNode: PVirtualNode; IsImport: Boolean = false);
    procedure InternalLoadOptions;
    procedure InternalSaveListItems(Tree:TBaseVirtualTree; ANode: PVirtualNode;AParentID: Int64);
    procedure InternalSaveData(Tree: TBaseVirtualTree; ANode: PVirtualNode;
      AParentID: Int64);
    procedure UpdateFileRecord(AData: TvBaseNodeData;AIndex, AParentID: Integer);
    procedure InsertFileRecord(AData: TvBaseNodeData;AIndex, AParentID: Integer);
    procedure InternalSaveVersion;
    procedure InternalSaveOptions;
    procedure ClearTable(SQLRecordClass:TSQLRecordClass);
    procedure UTF8ToMouseSensors(StringSensors: RawUTF8; MouseButton: TMouseButton);
    function  MouseSensorsToUTF8(MouseButton: TMouseButton): RawUTF8;
  public
    constructor Create(const DBFilePath: string);
    destructor Destroy; override;
    property DBFileName: string read FDBFileName write FDBFileName;
    property Database: TSQLRest read FDatabase write FDatabase;
    procedure DoBackupList;
    procedure LoadData(Tree: TBaseVirtualTree);
    function  SaveData(Tree: TBaseVirtualTree): Boolean;
    procedure DeleteItem(aID: Integer);
    procedure ImportData(Tree: TBaseVirtualTree); //For frmImportList
    procedure ImportOptions; //For frmImportList
  end;

var
  DBManager: TDBManager;

implementation

uses
  AppConfig, ulAppConfig, ulSysUtils, ulCommonUtils, ulTreeView, Main;

{ TDBManager }

constructor TDBManager.Create(const DBFilePath: String);
begin
  FDBFileName := DBFilePath;
  //Load sqlite3 database and create missing tables
  FSQLModel := TSQLModel.Create([TSQLtbl_version, TSQLtbl_files, TSQLtbl_options]);
  FDatabase := TSQLRestServerDB.Create(FSQLModel,FDBFileName);
  TSQLRestServerDB(fDatabase).CreateMissingTables(0);
  FASuiteVersion := TVersionInfo.Create;
end;

procedure TDBManager.DeleteItem(aID: Integer);
begin
  FDatabase.Delete(TSQLtbl_files,aID);
end;

destructor TDBManager.Destroy;
begin
  inherited;
  FDatabase.Free;
  FSQLModel.Free;
  FDBVersion.Free;
  FASuiteVersion.Free;
end;

procedure TDBManager.DoBackupList;
begin
  //Backup list and old delete backup
  if (Config.Backup) then
  begin
    CopyFile(PChar(FDBFileName),
             PChar(SUITE_BACKUP_PATH + APP_NAME + '_' + GetDateTime + EXT_SQLBCK), false);
    DeleteOldBackups(Config.BackupNumber);
  end;
end;

procedure TDBManager.ImportData(Tree: TBaseVirtualTree);
begin
  try
    InternalLoadListItems(Tree, 0, nil, true);
  except
    on E : Exception do
      ShowMessage(Format(msgErrGeneric,[E.ClassName,E.Message]),True);
  end;
end;

procedure TDBManager.ImportOptions;
begin
  try
    InternalLoadOptions;
  except
    on E : Exception do
      ShowMessage(Format(msgErrGeneric,[E.ClassName,E.Message]),True);
  end;
end;

procedure TDBManager.UTF8ToMouseSensors(StringSensors: RawUTF8; MouseButton: TMouseButton);
var
  Strs: TStringList;
  I: Integer;
begin
  //Mouse Sensor
  Strs := TStringList.Create;
  try
    Strs.Text := StringReplace(UTF8ToString(StringSensors), '.', ''#10'', [rfReplaceAll]);
    if MouseButton = mbLeft then
    begin
      for I := 0 to 3 do
        Config.SensorLeftClick[i] := StrToInt(Strs[I]);
    end
    else begin
      for I := 0 to 3 do
        Config.SensorRightClick[i] := StrToInt(Strs[I]);
    end;
  finally
    Strs.Free;
  end;
end;

procedure TDBManager.ClearTable(SQLRecordClass:TSQLRecordClass);
var
  SQLData: TSQLRecord;
begin
  SQLData := SQLRecordClass.CreateAndFillPrepare(FDatabase, '');
  try
    while SQLData.FillOne do
      FDatabase.Delete(SQLRecordClass, SQLData.ID);
  finally
    SQLData.Free;
  end;
end;

procedure TDBManager.InsertFileRecord(AData: TvBaseNodeData; AIndex,
  AParentID: Integer);
var
  SQLFilesData : TSQLtbl_files;
begin
  SQLFilesData := TSQLtbl_files.Create;
  try
    //Add base fields
    SQLFilesData.itemtype := Ord(AData.DataType);
    SQLFilesData.parent   := AParentID;
    SQLFilesData.position := AIndex;
    SQLFilesData.title    := StringToUTF8(AData.Name);
    SQLFilesData.cacheicon_id := AData.CacheID;
    //Add specific category and file fields
    if AData.DataType <> vtdtSeparator then
    begin
      SQLFilesData.icon_path      := StringToUTF8(AData.PathIcon);
      SQLFilesData.hide_from_menu := AData.HideFromMenu;
      //Add time fields
      SQLFilesData.dateAdded    := AData.UnixAddDate;
      SQLFilesData.lastModified := AData.UnixEditDate;
      //Add file fields
      if (AData.DataType = vtdtFile) then
      begin
        with TvFileNodeData(AData) do
        begin
          SQLFilesData.path       := StringToUTF8(PathExe);
          SQLFilesData.work_path  := StringToUTF8(WorkingDir);
          SQLFilesData.parameters := StringToUTF8(Parameters);
          SQLFilesData.clicks     := ClickCount;
          SQLFilesData.window_state := WindowState;
          SQLFilesData.dsk_shortcut := ShortcutDesktop;
          SQLFilesData.autorun    := Ord(Autorun);
          SQLFilesData.autorun_position := AutorunPos;
          SQLFilesData.onlaunch   := Ord(ActionOnExe);
          SQLFilesData.no_mru     := NoMRU;
          SQLFilesData.no_mfu     := NoMFU;
          SQLFilesData.lastAccess := MRUPosition;
        end;
      end;
    end;
  finally
    //Set ID, ParentID and position
    AData.ID       := FDatabase.Add(SQLFilesData,true);
    AData.ParentID := AParentID;
    AData.Position := AIndex;
    SQLFilesData.Free;
  end;
end;

procedure TDBManager.InternalLoadData(Tree: TBaseVirtualTree);
begin
  try
    //Load Database version
    InternalLoadVersion;
    //Load Options
    InternalLoadOptions;
    //Create special list
    MRUList := TMRUList.Create;
    MFUList := TMFUList.Create;
    //Create folder cache, if it doesn't exist
    if (not DirectoryExists(SUITE_CACHE_PATH)) then
      CreateDir(SUITE_CACHE_PATH);
    //Create folder backup, if it doesn't exist
    if not (DirectoryExists(SUITE_BACKUP_PATH)) then
      CreateDir(SUITE_BACKUP_PATH);
    //Load list
    InternalLoadListItems(Tree, 0, nil, false);
  except
    on E : Exception do
      ShowMessage(Format(msgErrGeneric,[E.ClassName,E.Message]),True);
  end;
end;

procedure TDBManager.InternalLoadListItems(Tree: TBaseVirtualTree; ID: Integer;
  ParentNode: PVirtualNode; IsImport: Boolean = false);
var
  SQLFilesData : TSQLtbl_files;
  nType    : TvTreeDataType;
  vData    : TvBaseNodeData;
  Node     : PVirtualNode;
begin
  //Get files from DBTable and order them by parent, position
  SQLFilesData := TSQLtbl_files.CreateAndFillPrepare(FDatabase,'parent=? ORDER BY parent, position',[ID]);
  try
    //Get files and its properties
    while SQLFilesData.FillOne do
    begin
      nType := TvTreeDataType(SQLFilesData.itemtype);
      Node  := Tree.AddChild(ParentNode, CreateNodeData(nType));
      vData := PBaseData(Tree.GetNodeData(Node)).Data;
      PBaseData(Tree.GetNodeData(Node)).pNode := Node;
      if IsImport then
        Tree.CheckType[Node] := ctTriStateCheckBox
      else
        vData.CacheID     := SQLFilesData.cacheicon_id;
      // generic fields
      vData.Name          := UTF8ToString(SQLFilesData.title);
      vData.id            := SQLFilesData.ID;
      vData.ParentID      := id;
      vData.Position      := Node.Index;
      vData.UnixAddDate   := SQLFilesData.dateAdded;
      vData.UnixEditDate  := SQLFilesData.lastModified;
      vData.ParentNode    := ParentNode;
      vData.PathIcon      := UTF8ToString(SQLFilesData.icon_path);
      vData.HideFromMenu  := SQLFilesData.hide_from_menu;
      if (nType = vtdtFile) then
      begin
        with TvFileNodeData(vData) do
        begin
          PathExe          := UTF8ToString(SQLFilesData.path);
          Parameters       := UTF8ToString(SQLFilesData.parameters);
          WorkingDir       := UTF8ToString(SQLFilesData.work_path);
          ClickCount       := SQLFilesData.clicks;
          ShortcutDesktop  := SQLFilesData.dsk_shortcut;
          AutorunPos       := SQLFilesData.autorun_position;
          Autorun          := TAutorunType(SQLFilesData.autorun);
          WindowState      := SQLFilesData.window_state;
          ActionOnExe      := TActionOnExecution(SQLFilesData.onlaunch);
          NoMRU            := SQLFilesData.no_mru;
          NoMFU            := SQLFilesData.no_mfu;
          MRUPosition      := SQLFilesData.lastAccess;
        end;
      end;
      if (nType = vtdtCategory) then
        InternalLoadListItems(Tree, vData.ID, Node, IsImport);
    end;
  finally
    SQLFilesData.Free;
  end;
end;

procedure TDBManager.InternalLoadOptions;
var
  SQLOptionsData : TSQLtbl_options;
begin
  if FDatabase.TableHasRows(TSQLtbl_version) then
  begin
    SQLOptionsData := TSQLtbl_options.CreateAndFillPrepare(FDatabase,'');
    try
      //Get options from DBTable
      while SQLOptionsData.FillOne do
      begin
        //General
        Config.StartWithWindows   := SQLOptionsData.startwithwindows;
        Config.ShowPanelAtStartUp := SQLOptionsData.showpanelatstartup;
        Config.ShowMenuAtStartUp  := SQLOptionsData.showmenuatstartup;
        //Main Form
        { TODO -oMatteo -c : Insert code for language 26/11/2009 22:21:05 }
    //      FLanguage           := '';
        Config.CustomTitleString := UTF8ToString(SQLOptionsData.customtitlestring);
        Config.UseCustomTitle    := SQLOptionsData.usecustomtitle;
        Config.HideTabSearch     := SQLOptionsData.hidetabsearch;
        //Main Form - Position and size
        Config.HoldSize    := SQLOptionsData.holdsize;
        Config.AlwaysOnTop := SQLOptionsData.alwaysontop;
        //frmMain's size
        frmMain.Width      := SQLOptionsData.listformwidth;
        frmMain.Height     := SQLOptionsData.listformheight;
        //FrmMain's position
        if Not(FileExists(SUITE_LIST_PATH)) then
          frmMain.Position := poDesigned
        else
          frmMain.Position := poDesktopCenter;
        SetFormPosition(frmMain, SQLOptionsData.listformleft, SQLOptionsData.listformtop);
        //Main Form - Treevew
        Config.TVBackgroundPath   := UTF8ToString(SQLOptionsData.tvbackgroundpath);
        Config.TVBackground       := SQLOptionsData.tvbackground;
        Config.TVAutoOpClCats     := SQLOptionsData.tvautoopclcats;
        //Treeview Font
        Config.TVFont.Free;
        Config.TVFont         := StrToFont(UTF8ToString(SQLOptionsData.tvfont));
        //MRU
        Config.MRU            := SQLOptionsData.mru;
        Config.SubMenuMRU     := SQLOptionsData.submenumru;
        Config.MRUNumber      := SQLOptionsData.mrunumber;
        //MFU
        Config.MFU            := SQLOptionsData.mfu;
        Config.SubMenuMFU     := SQLOptionsData.submenumfu;
        Config.MFUNumber      := SQLOptionsData.mfunumber;
        //Backup
        Config.Backup         := SQLOptionsData.backup;
        Config.BackupNumber   := SQLOptionsData.backupnumber;
        //Other functions
        Config.Autorun        := SQLOptionsData.autorun;
        Config.Cache          := SQLOptionsData.cache;
        //Execution
        Config.ActionOnExe    := TActionOnExecution(SQLOptionsData.actiononexe);
        Config.RunSingleClick := SQLOptionsData.runsingleclick;
        //Trayicon
        Config.TrayIcon           := SQLOptionsData.trayicon;
        Config.TrayCustomIconPath := UTF8ToString(SQLOptionsData.traycustomiconpath);
        Config.TrayUseCustomIcon  := SQLOptionsData.trayusecustomicon;
        Config.ActionClickLeft    := SQLOptionsData.actionclickleft;
        Config.ActionClickRight   := SQLOptionsData.actionclickright;
        //Mouse sensors
        UTF8ToMouseSensors(SQLOptionsData.mousesensorleft,mbLeft);
        UTF8ToMouseSensors(SQLOptionsData.mousesensorright,mbRight);
      end
    finally
      SQLOptionsData.Free;
      Config.UpdateSensors;
    end;
  end
  else
    Config.Changed := True;
end;

procedure TDBManager.LoadData(Tree: TBaseVirtualTree);
begin
  //List & Options
  DBManager.InternalLoadData(Tree);
  //Backup sqlite database
  DBManager.DoBackupList;
  //Get rootnode's Icons
  GetChildNodesIcons(Tree, Tree.RootNode);
end;

function TDBManager.MouseSensorsToUTF8(MouseButton: TMouseButton): RawUTF8;
var
  I: Integer;
  SensorString: String;
begin
  SensorString := '';
  for I := 0 to 3 do
  begin
    if MouseButton = mbLeft then
      SensorString := SensorString + IntToStr(Config.SensorLeftClick[I])
    else
      if MouseButton = mbRight then
        SensorString := SensorString + IntToStr(Config.SensorRightClick[I]);
    if I <> 3 then
      SensorString := SensorString + '.'
  end;
  Result := StringToUTF8(SensorString);
end;

procedure TDBManager.InternalLoadVersion;
var
  SQLVersionData: TSQLtbl_version;
begin
  if FDatabase.TableHasRows(TSQLtbl_version) then
  begin
    //Get sql data and get version info
    SQLVersionData := TSQLtbl_version.CreateAndFillPrepare(FDatabase,'');
    try
      SQLVersionData.FillOne;
      //Create FDBVersion with db version info
      FDBVersion := TVersionInfo.Create(SQLVersionData.Major,
                                        SQLVersionData.Minor,
                                        SQLVersionData.Release,
                                        SQLVersionData.Build);
    finally
      SQLVersionData.Free;
    end;
  end
  else begin
    //Create FDBVersion with actual ASuite version info
    FDBVersion := TVersionInfo.Create;
  end;
end;

procedure TDBManager.InternalSaveData(Tree: TBaseVirtualTree;
  ANode: PVirtualNode; AParentID: Int64);
begin
  try
    //Create and open Sqlite3Dataset
    if FDatabase.TransactionBegin(TSQLtbl_files,1) then
    begin
      InternalSaveListItems(Tree, Anode, AParentID);
      //If settings is changed, insert it else (if it exists) update it
      if Config.Changed then
        InternalSaveOptions;
      //Save new version info
      InternalSaveVersion;
      //Commit data in sqlite database
      FDatabase.Commit(1);
    end;
  except
    on E : Exception do begin
      ShowMessage(Format(msgErrGeneric,[E.ClassName,E.Message]),True);
      FDatabase.Rollback(1);
    end;
  end;
end;

procedure TDBManager.InternalSaveListItems(Tree: TBaseVirtualTree;
  ANode: PVirtualNode; AParentID: Int64);
var
  Node    : PVirtualNode;
  vData   : TvBaseNodeData;
begin
  Node    := ANode;
  while (Node <> nil) do
  begin
    vData := PBaseData(Tree.GetNodeData(Node)).Data;
    try
      //Insert or update record
      if (vData.ID < 0) then
        InsertFileRecord(vData, Node.Index, AParentID)
      else
        if ((vData.Changed) or (vData.Position <> Node.Index) or (vData.ParentID <> AParentID)) then
          UpdateFileRecord(vData, Node.Index, AParentID);
      //If type is category then process sub-nodes
      if (vData.DataType = vtdtCategory) then
        InternalSaveListItems(Tree, Node.FirstChild, vData.ID);
    except
      on E : Exception do
        ShowMessage(Format(msgErrGeneric,[E.ClassName,E.Message]),True);
    end;
    Node := Node.NextSibling;
  end;
end;

procedure TDBManager.InternalSaveOptions;
var
  SQLOptionsData : TSQLtbl_options;
begin
  //Clear options table
  if FDatabase.TableHasRows(TSQLtbl_options) then
    ClearTable(TSQLtbl_options);
  //Save ASuite options
  SQLOptionsData := TSQLtbl_options.Create;
  try
    //general
    SQLOptionsData.startwithwindows   := Config.StartWithWindows;
    SQLOptionsData.showpanelatstartup := Config.ShowPanelAtStartUp;
    SQLOptionsData.showmenuatstartup  := Config.ShowMenuAtStartUp;
    //main form
    //SQLOptionsData.language           := Config.Language;
    SQLOptionsData.usecustomtitle    := Config.UseCustomTitle;
    SQLOptionsData.customtitlestring := StringToUTF8(Config.CustomTitleString);
    SQLOptionsData.hidetabsearch     := Config.HideTabSearch;
    //main form - position and size
    SQLOptionsData.holdsize          := Config.HoldSize;
    SQLOptionsData.alwaysontop       := Config.AlwaysOnTop;
    SQLOptionsData.listformtop       := frmMain.Top;
    SQLOptionsData.listformleft      := frmMain.Left;
    SQLOptionsData.listformwidth     := frmMain.Width;
    SQLOptionsData.listformheight    := frmMain.Height;
    //main form - treevew
    SQLOptionsData.tvbackground      := Config.TVBackground;
    SQLOptionsData.tvbackgroundpath  := StringToUTF8(Config.TVBackgroundPath);
    SQLOptionsData.tvautoopclcats    := Config.TVAutoOpClCats;
    SQLOptionsData.tvfont            := StringToUTF8(FontToStr(Config.TVFont));
    //mru
    SQLOptionsData.mru          := Config.MRU;
    SQLOptionsData.submenumru   := Config.SubMenuMRU;
    SQLOptionsData.mrunumber    := Config.MRUNumber;
    //mfu
    SQLOptionsData.mfu          := Config.MFU;
    SQLOptionsData.submenumfu   := Config.SubMenuMFU;
    SQLOptionsData.mfunumber    := Config.MFUNumber;
    //backup
    SQLOptionsData.backup       := Config.Backup;
    SQLOptionsData.backupnumber := Config.BackupNumber;
    //other functions
    SQLOptionsData.autorun      := Config.Autorun;
    SQLOptionsData.cache        := Config.Cache;
    //execution
    SQLOptionsData.actiononexe    := TActionOnExecution(Config.ActionOnExe);
    SQLOptionsData.runsingleclick := Config.RunSingleClick;
    //trayicon
    SQLOptionsData.trayicon := Config.TrayIcon;
    SQLOptionsData.trayusecustomicon  := Config.TrayUseCustomIcon;
    SQLOptionsData.traycustomiconpath := StringToUTF8(Config.TrayCustomIconPath);
    SQLOptionsData.actionclickleft    := Config.ActionClickLeft;
    SQLOptionsData.actionclickright   := Config.ActionClickRight;
    //Mouse Sensor
    SQLOptionsData.mousesensorleft  := MouseSensorsToUTF8(mbLeft);
    SQLOptionsData.mousesensorright := MouseSensorsToUTF8(mbRight);
    FDatabase.Add(SQLOptionsData,true);
  finally
    SQLOptionsData.Free;
  end;
end;

procedure TDBManager.InternalSaveVersion;
var
  SQLVersionData: TSQLtbl_version;
begin
  //If necessary, clear version table
  if FDatabase.TableHasRows(TSQLtbl_version) then
  begin
    if CompareVersionInfo(FDBVersion,FASuiteVersion) <> 0 then
      ClearTable(TSQLtbl_version)
    else
      Exit;
  end;
  //Insert ASuite version info
  SQLVersionData := TSQLtbl_version.Create;
  try
    SQLVersionData.Major   := FASuiteVersion.Major;
    SQLVersionData.Minor   := FASuiteVersion.Minor;
    SQLVersionData.Release := FASuiteVersion.Release;
    SQLVersionData.Build   := FASuiteVersion.Build;
    FDatabase.Add(SQLVersionData,true);
  finally
    SQLVersionData.Free;
  end;
end;

function TDBManager.SaveData(Tree: TBaseVirtualTree): Boolean;
begin
  Result := True;
  //If launcher is in ReadOnlyMode, exit from this function
  if (Config.ReadOnlyMode) then
    Exit;
  //List & Options
  try
    DBManager.InternalSaveData(Tree,Tree.GetFirst,0);
  except
    Result := False;
  end;
end;

procedure TDBManager.UpdateFileRecord(AData: TvBaseNodeData; AIndex,
  AParentID: Integer);
var
  SQLFilesData : TSQLtbl_files;
begin
  //Select only file record by ID
  SQLFilesData := TSQLtbl_files.CreateAndFillPrepare(FDatabase,'id=?',[AData.ID]);
  try
    if SQLFilesData.FillOne then
    begin
      //Update base fields
      SQLFilesData.parent   := AParentID;
      SQLFilesData.position := AIndex;
      SQLFilesData.title    := StringToUTF8(AData.Name);
      SQLFilesData.cacheicon_id := AData.CacheID;
      //Update specific fields
      if AData.DataType <> vtdtSeparator then
      begin
        SQLFilesData.icon_path      := StringToUTF8(AData.PathIcon);
        SQLFilesData.hide_from_menu := AData.HideFromMenu;
        //Update time fields
        SQLFilesData.dateAdded    := AData.UnixAddDate;
        SQLFilesData.lastModified := AData.UnixEditDate;
        //Update specific fields
        if (AData.DataType = vtdtFile) then
        begin
          with TvFileNodeData(AData) do
          begin
            SQLFilesData.path       := StringToUTF8(PathExe);
            SQLFilesData.work_path  := StringToUTF8(WorkingDir);
            SQLFilesData.parameters := StringToUTF8(Parameters);
            SQLFilesData.clicks     := ClickCount;
            SQLFilesData.window_state := WindowState;
            SQLFilesData.dsk_shortcut := ShortcutDesktop;
            SQLFilesData.autorun    := Ord(Autorun);
            SQLFilesData.autorun_position := AutorunPos;
            SQLFilesData.onlaunch   := Ord(ActionOnExe);
            SQLFilesData.no_mru     := NoMRU;
            SQLFilesData.no_mfu     := NoMFU;
            SQLFilesData.lastAccess := MRUPosition;
          end;
        end;
      end;
    end;
  finally
    //Update data
    FDatabase.Update(SQLFilesData);
    //Update node
    AData.ParentID := AParentID;
    AData.Position := AIndex;
    SQLFilesData.Free;
  end;
end;

initialization

finalization
  DBManager.Free

end.
