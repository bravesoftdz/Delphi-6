unit AtmaRet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Data.DB,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, IniFiles, Vcl.ExtDlgs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP;

type
  TForm1 = class(TForm)
    Dtinicial: TDateTimePicker;
    Dtfinal: TDateTimePicker;
    label1: TLabel;
    Edlocalbanco: TEdit;
    Btsalvarlbanco: TButton;
    Label8: TLabel;
    Btlocal: TButton;
    Button2: TButton;
    Label9: TLabel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Label5: TLabel;
    Label3: TLabel;
    DBGR05: TDBGrid;
    DBGR03: TDBGrid;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    SGresultador05: TStringGrid;
    Btcalcdiferenca: TButton;
    Btratiar: TButton;
    Label7: TLabel;
    TabSheet5: TTabSheet;
    DBGrid1: TDBGrid;
    Label13: TLabel;
    Button3: TButton;
    DBGrid2: TDBGrid;
    Label14: TLabel;
    Button5: TButton;
    Button4: TButton;
    Button6: TButton;
    qtder05: TLabel;
    DBGridVendas: TDBGrid;
    Button7: TButton;
    Label15: TLabel;
    Btpesquisa: TButton;
    Label11: TLabel;
    Label12: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGcancelado: TDBGrid;
    TabSheet2: TTabSheet;
    SGtotalcancel: TStringGrid;
    Button1: TButton;
    Btajuste: TButton;
    DBGrid3: TDBGrid;
    LbtTotalizadoresDivergentes: TLabel;
    Label16: TLabel;
    OpenDialogLocalBanco: TOpenDialog;
    Button8: TButton;
    Label10: TLabel;
    IdFTP1: TIdFTP;
    procedure BtpesquisaClick(Sender: TObject);
    procedure threadr03;
    procedure thread05;
    procedure threadiferenca;
    procedure RatiarNegativoGrandeR05(porcentagem: Double; serie: String;
      Data: TDate; aliquota: String);
    procedure Resultador03;
    procedure Resultador05;
    procedure FormCreate(Sender: TObject);
    procedure BtcalcdiferencaClick(Sender: TObject);
    procedure BtratiarClick(Sender: TObject);
    procedure BtsalvarlbancoClick(Sender: TObject);
    procedure Comparar04r05;
    procedure pesquisacancelado;
    // function Comparaaliquota(tparcial: String; aliquota: String): Boolean;
    procedure BtlocalClick(Sender: TObject);
    procedure RatiarValores;
    procedure CorrigePositivo(i: Integer);
    procedure CorrigeNegativo(i: Integer);
    procedure PesquisaR03R05;
    procedure TotalizaCancelado;
    procedure MarcaCancelado;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AtualizaVenda;
    procedure Button3Click(Sender: TObject);
    procedure CalculaIcms;
    procedure Button4Click(Sender: TObject);
    procedure AtualizaVendaCFOP(verif: Boolean);
    procedure Button6Click(Sender: TObject);
    procedure BtajusteClick(Sender: TObject);
    function Ajustetotalizadores(sql: String; dtini: TDate;
      dtfin: TDate): Boolean;
    procedure VendaCancelado;
    procedure Button7Click(Sender: TObject);
    procedure TotalizadoresDivergentes;
    procedure Corrigetotalizador;
    procedure Button8Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CorrigePositivo490(serie: String;data: TDate;caliq: String;valor: Double);
    procedure CorrigeNegativo490(serie: String;data: TDate;caliq: String;valor: Double;porce: Double);
    procedure Corrige490;
    procedure thread490;
    procedure RatiarNegativoGrandeR05490 (serie: String;data: TDate;caliq: String;valor: Double);
    procedure PesquisaErro490;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  // teste : MinhaThread;
implementation

{$R *.dfm}

uses Udm, Utread, Utreadr05, Utreaddiferenca, FMTBcd, Umenssagem, Utreadrateio,
  UtreadMarcaCancelado, Uemail, Uthreadaliquota, UthreadIcmsDVenda, Uteste,
  UthreadVendaCancelado, UmudancasVersao, Uthreadcorrige490, Ulogin;

procedure TForm1.Resultador03;
begin
  try
    dm.ClientDataSet1.Open;
    thread05;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);

    end;
  end;

end;

procedure TForm1.Resultador05;
begin
  try
    dm.ClientDataSet2.Open;
    TFormenssagem.Close;
    Form1.Enabled := true;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
  Label5.Caption := 'Pesquisa Concluida';
end;

procedure TForm1.pesquisacancelado;
begin
  Label11.Caption := 'Pesquisa sendo Processada';
  // dm.SQLConnection1.Close;
  dm.ClientDataSetVerificaR04.Close;
  dm.SQLDataSetVerificaR04.ParamByName('DAT1').AsDate := Dtinicial.Date;
  dm.SQLDataSetVerificaR04.ParamByName('DAT2').AsDate := Dtfinal.Date;
  dm.ClientDataSetVerificaR04.Open;
  Label11.Caption := 'Pesquisa concluida';
  Label12.Caption := IntToStr(dm.ClientDataSetVerificaR04.RecordCount);
  TotalizaCancelado;
end;

procedure TForm1.TotalizadoresDivergentes;
begin
  dm.ClientDataSetAliquotasDiferente.Close;
  dm.SQLDataSetAliquotasDiferente.ParamByName('dtini').AsDate := Dtinicial.Date;
  dm.SQLDataSetAliquotasDiferente.ParamByName('dtfin').AsDate := Dtfinal.Date;
  dm.ClientDataSetAliquotasDiferente.Open;
  LbtTotalizadoresDivergentes.Caption := 'Pesquisa Concluida'
end;

procedure TForm1.TotalizaCancelado;
var
  i: Integer;
  nf: String;
  cont: Integer;
  conf: String;
  Data: TDateTime;
begin
  SGtotalcancel.RowCount := 1;
  cont := 0;
  nf := '';
  i := 0;
  if dm.ClientDataSetVerificaR04.RecordCount > 0 then
  begin
    nf := dm.ClientDataSetVerificaR04NRFAB.Value;
    Data := dm.ClientDataSetVerificaR04EMISSAOD.Value;

    while i < dm.ClientDataSetVerificaR04.RecordCount do
    begin
      if (dm.ClientDataSetVerificaR04NRFAB.Value = nf) and
        (dm.ClientDataSetVerificaR04EMISSAOD.Value = Data) then
      begin
        i := i + 1;
        cont := cont + 1;
        dm.ClientDataSetVerificaR04.Next;
      end
      else
      begin

        SGtotalcancel.RowCount := SGtotalcancel.RowCount + 1;
        SGtotalcancel.Cells[0, SGtotalcancel.RowCount - 1] := nf;
        SGtotalcancel.Cells[1, SGtotalcancel.RowCount - 1] := DateToStr(Data);
        SGtotalcancel.Cells[2, SGtotalcancel.RowCount - 1] := IntToStr(cont);
        cont := 0;
        nf := dm.ClientDataSetVerificaR04NRFAB.Value;
        Data := dm.ClientDataSetVerificaR04EMISSAOD.Value;
      end;
    end;
  end;
  if nf <> '' then
  begin
    SGtotalcancel.RowCount := SGtotalcancel.RowCount + 1;
    SGtotalcancel.Cells[0, SGtotalcancel.RowCount - 1] := nf;
    SGtotalcancel.Cells[1, SGtotalcancel.RowCount - 1] := DateToStr(Data);
    SGtotalcancel.Cells[2, SGtotalcancel.RowCount - 1] := IntToStr(cont);
  end;
end;

procedure TForm1.BtlocalClick(Sender: TObject);
begin
  if OpenDialogLocalBanco.Execute then
    Edlocalbanco.Text := OpenDialogLocalBanco.FileName;
end;

procedure TForm1.BtpesquisaClick(Sender: TObject);

begin
  dm.SQLConnection1.Open;
  if dm.SQLConnection1.Connected then
  begin
    TFormenssagem.Show;
    Form1.Enabled := false;
    PesquisaR03R05;
    // thread05;
  end;
end;

procedure TForm1.PesquisaR03R05;
begin
  qtder05.Caption := '0';
  SGresultador05.RowCount := 1;
  Label7.Caption := '';
  threadr03;
end;

procedure TForm1.threadr03;
var
  Teste: MinhaThread;
begin
  dm.ClientDataSet1.Close;
  // dm.SQLConnection1.Close;
  Label4.Caption := 'Pesquisa sendo Processada';
  dm.SQLDataSet1.ParamByName('dtinicial').AsDate := Dtinicial.Date;
  dm.SQLDataSet1.ParamByName('dtfinal').AsDate := Dtfinal.Date;
  Teste := MinhaThread.Create(true);
  Teste.FreeOnTerminate := true;
  Teste.Priority := tpHigher;
  Teste.Resume;

end;

procedure TForm1.thread05;
var
  Teste: Threadr05;
begin
  try
    dm.ClientDataSet2.Close;
    // dm.SQLConnection1.Close;
    Label5.Caption := 'Pesquisa sendo Processada';
    dm.SQLDataSet2.ParamByName('dtinicial').AsDate := Dtinicial.Date;
    dm.SQLDataSet2.ParamByName('dtfinal').AsDate := Dtfinal.Date;
    Teste := Threadr05.Create(true);
    Teste.FreeOnTerminate := true;
    Teste.Priority := tpHigher;
    Teste.Resume;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TForm1.threadiferenca;
var
  thread: ThreadDiferenca;
begin
  try
    thread := ThreadDiferenca.Create();
    thread.FreeOnTerminate := true;
    thread.Priority := tpHigher;
    thread.Resume
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;

end;

procedure TForm1.BtajusteClick(Sender: TObject);
begin
  if dm.ClientDataSetAliquotasDiferente.Active then
  begin
    if dm.ClientDataSetAliquotasDiferente.RecordCount > 0 then
    begin
      Corrigetotalizador;
    end
    else
    begin
      ShowMessage('N�o a Registro Para Atualizar');
    end;
  end
  else
  begin
    ShowMessage('Primeiro Fa�a a Pesquisa !!');
  end;

end;

procedure TForm1.Corrigetotalizador;
var
  i: Integer;
begin
  dm.ClientDataSetAliquotasDiferente.First;
  for i := +1 to dm.ClientDataSetAliquotasDiferente.RecordCount do
  begin

    if dm.ClientDataSetAliquotasDiferenteNR_TOT.Value = 'FF' then
    begin
      if not Ajustetotalizadores
        ('update r05 SET R05.caliq=''STB'' where r05.id_r05_sg=' +
        IntToStr(dm.ClientDataSetAliquotasDiferenteID_R05_SG.Value) +
        ' AND  r05.emissaod between :dtini and :dtfin',
        dm.ClientDataSetAliquotasDiferenteEMISSAOD.Value,
        dm.ClientDataSetAliquotasDiferenteEMISSAOD.Value) then
      begin
        ShowMessage('Erro ao Atualizar Substitui��o  ' +
          IntToStr(dm.ClientDataSetAliquotasDiferenteID_R05_SG.Value));
      end;
    end
    else if dm.ClientDataSetAliquotasDiferenteNR_TOT.Value = 'II' then
    begin
      if not Ajustetotalizadores
        ('update r05 SET R05.caliq=''IST'' where r05.id_r05_sg=' +
        IntToStr(dm.ClientDataSetAliquotasDiferenteID_R05_SG.Value) +
        ' AND  r05.emissaod between :dtini and :dtfin',
        dm.ClientDataSetAliquotasDiferenteEMISSAOD.Value,
        dm.ClientDataSetAliquotasDiferenteEMISSAOD.Value) then
      begin
        ShowMessage('Erro ao Atualizar Isento  ' +
          IntToStr(dm.ClientDataSetAliquotasDiferenteID_R05_SG.Value));
      end;
    end
    else
    begin
      if not Ajustetotalizadores
        ('update r05 SET R05.caliq=r05.nr_tot where r05.id_r05_sg=' +
        IntToStr(dm.ClientDataSetAliquotasDiferenteID_R05_SG.Value) +
        ' AND  r05.emissaod between :dtini and :dtfin',
        dm.ClientDataSetAliquotasDiferenteEMISSAOD.Value,
        dm.ClientDataSetAliquotasDiferenteEMISSAOD.Value) then
      begin
        ShowMessage('Erro ao Atualizar Tributado  ' +
          IntToStr(dm.ClientDataSetAliquotasDiferenteID_R05_SG.Value));
      end;
    end;
    dm.ClientDataSetAliquotasDiferente.Next;
  end;
  ShowMessage('Aliquotas Atualizadas');
end;

function TForm1.Ajustetotalizadores(sql: String; dtini: TDate;
  dtfin: TDate): Boolean;
begin
  dm.SQLConnection1.Close;
  dm.SQLQueryajustetotalizadores.Close;
  dm.SQLQueryatualizaaliquota.sql.Clear;
  dm.SQLQueryajustetotalizadores.sql.Text := sql;
  dm.SQLQueryajustetotalizadores.ParamByName('dtini').AsDate := dtini;
  dm.SQLQueryajustetotalizadores.ParamByName('dtfin').AsDate := dtfin;
  try
    begin
      dm.SQLQueryajustetotalizadores.ExecSQL(false);
      Result := true;
    end;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Result := false;
    end;
  end;

end;

procedure TForm1.BtcalcdiferencaClick(Sender: TObject);
begin
  TFormenssagem.Show;
  Form1.Enabled := false;
  Label7.Caption := 'Calculo sendo Feito';

  threadiferenca;

end;

procedure TForm1.Comparar04r05;
var
  i: Integer;
  j: Integer;
var
  v1: Real;
  v2: Real;
var
  aliq: String;
begin
  dm.ClientDataSet1.First;
  dm.ClientDataSet2.First;
  SGresultador05.RowCount := 1;
  for i := +1 to dm.ClientDataSet1.RecordCount do
  begin
    try
      dm.ClientDataSet2.Filtered := false;
      dm.ClientDataSet2.Filter := 'NRFAB like ''%' +
        dm.ClientDataSet1NRFAB.Value + '%'' AND TPARCIAL like ''%' +
        dm.ClientDataSet1TPARCIAL.Value + '%''';
      dm.ClientDataSet2.Filtered := true;
      for j := +1 to dm.ClientDataSet2.RecordCount do
      begin
        { if Comparaaliquota(dm.ClientDataSet2TPARCIAL.Value,
          dm.ClientDataSet2CALIQ.Value) then
          begin }
        if dm.ClientDataSet1EMISSAOD.Value = dm.ClientDataSet2EMISSAOD.Value
        then
        begin
          if dm.ClientDataSet1NRFAB.Value = dm.ClientDataSet2NRFAB.Value then
          begin
            if dm.ClientDataSet1TPARCIAL.Value = dm.ClientDataSet2TPARCIAL.Value
            then
            begin
              if (dm.ClientDataSet1SUM.Value <> dm.ClientDataSet2CAST.Value) and
                (((dm.ClientDataSet1SUM.Value - dm.ClientDataSet2CAST.Value) >
                0.09) or ((dm.ClientDataSet1SUM.Value -
                dm.ClientDataSet2CAST.Value) < -0.09)) then
              begin
                SGresultador05.RowCount := SGresultador05.RowCount + 1;
                SGresultador05.Cells[0, SGresultador05.RowCount - 1] :=
                  dm.ClientDataSet1NRFAB.Value;
                SGresultador05.Cells[1, SGresultador05.RowCount - 1] :=
                  dm.ClientDataSet2CALIQ.Value;
                SGresultador05.Cells[2, SGresultador05.RowCount - 1] :=
                  DateToStr(dm.ClientDataSet1EMISSAOD.Value);
                {
                  v2 := BcdToDouble(dm.ClientDataSet1SUM.Value -
                  dm.ClientDataSet2CAST.Value);
                }
                SGresultador05.Cells[3, SGresultador05.RowCount - 1] :=
                  BcdToStr(dm.ClientDataSet1SUM.Value -
                  dm.ClientDataSet2CAST.Value);

                v1 := (StrToFloat(SGresultador05.Cells[3,
                  SGresultador05.RowCount - 1]) /
                  BcdToDouble(dm.ClientDataSet2CAST.Value)) * 100;
                SGresultador05.Cells[4, SGresultador05.RowCount - 1] :=
                  FormatFloat('0.0000', v1);
              end;
            end;
          end;
        end;
        // end;
        dm.ClientDataSet2.Next;
      end;
      dm.ClientDataSet1.Next;
    except
      on E: Exception do
        ShowMessage('Erro de Parametro' + dm.ClientDataSet1NRFAB.Value + #13 +
          dm.ClientDataSet1TPARCIAL.Value + #13 +
          DateToStr(dm.ClientDataSet1EMISSAOD.Value));
    end;
  end;
  Label7.Caption := 'Calculo Terminado';
  qtder05.Caption := IntToStr(SGresultador05.RowCount - 1);
  dm.ClientDataSet2.Filtered := false;
  TFormenssagem.Close;
  Form1.Enabled := true;

end;

procedure TForm1.BtratiarClick(Sender: TObject);
var
  thread: ThreadRateio;
begin
  if SGresultador05.RowCount > 1 then
  begin
    if SGtotalcancel.RowCount = 1 then
    begin
      { if SGerroraliquota.RowCount = 1 then
        begin
      }
      try
        TFormenssagem.Show;
        Form1.Enabled := false;
        TFormenssagem.Lbmenssagem.Caption := 'RATEIO SENDO PROCESSADO';
        thread := ThreadRateio.Create();
        thread.FreeOnTerminate := true;
        thread.Priority := tpNormal;
        thread.Resume;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
      exit;
      // end;
    end;
    ShowMessage('Por Favor Corrija os erros !!!');
  end
  else
  begin
    ShowMessage('N�o a Valor Para Ser Corrigido');
  end;

end;

procedure TForm1.RatiarValores;
var
  i: Integer;
begin
  for i := +1 to SGresultador05.RowCount - 1 do
  begin
    if StrToFloat(SGresultador05.Cells[3, i]) > 0 then
    begin
      CorrigePositivo(i);
      // passa como parametro a posi��o da linha na String Grid
    end
    else
    begin
      CorrigeNegativo(i);
      // passa como parametro a posicao da linha na string Grid
    end;
  end;
  // RatiarMaior5;  //ratia meio que 5

end;

procedure TForm1.CorrigePositivo(i: Integer);
var
  j: Integer;
  id: Integer;
  sql: String;
begin
  dm.SQLConnection1.Close;
  dm.ClientDataSetpesqr05positivo.Close;

  dm.SQLDataSetpesqr05positivo.ParamByName('serie').AsString :=
    SGresultador05.Cells[0, i];
  dm.SQLDataSetpesqr05positivo.ParamByName('dt').AsDate :=
    StrToDate(SGresultador05.Cells[2, i]);
  dm.SQLDataSetpesqr05positivo.ParamByName('caliq').AsString :=
    SGresultador05.Cells[1, i];
  dm.ClientDataSetpesqr05positivo.Open;

  dm.ClientDataSetpesqr05positivo.First;
  id := 0;
  for j := 1 to dm.ClientDataSetpesqr05positivo.RecordCount do
  begin
    if BcdToInteger(dm.ClientDataSetpesqr05positivoID_R05_SG.Value) > id then
    begin
      id := BcdToInteger(dm.ClientDataSetpesqr05positivoID_R05_SG.Value);
    end;
    dm.ClientDataSetpesqr05positivo.Next;
  end;

  dm.ClientDataSetpesqr05positivo.Close; // fecha conexao pesquisa positivo;
  dm.SQLQueryAtualizaValorR05.Close;
  dm.SQLConnection1.Close;
  dm.SQLQueryAtualizaValorR05.sql.Clear;
  sql := 'update r05 set BICMS2=(BICMS2+(:valor)),BICMS7=(BICMS7+(:valor)),VLIQ=(VLIQ+(:valor)),vrunit=(vrunit+(:valor)),TITEMB=(TITEMB+(:valor)) where id_r05_sg=:id';
  dm.SQLQueryAtualizaValorR05.sql.Text := sql;
  dm.SQLQueryAtualizaValorR05.ParamByName('valor').AsFMTBCD :=
    SGresultador05.Cells[3, i];
  dm.SQLQueryAtualizaValorR05.ParamByName('id').AsString := IntToStr(id);
  dm.SQLQueryAtualizaValorR05.ExecSQL(false);

end;

procedure TForm1.CorrigeNegativo(i: Integer);
var
  j: Integer;
  valor: Real;
  sql: String;
  id: Integer;
begin

  dm.SQLConnection1.Close;
  dm.ClientDataSetpesqr05valores.Close;
  dm.SQLDataSetpesqr05valores.ParamByName('serie').AsString :=
    SGresultador05.Cells[0, i];
  dm.SQLDataSetpesqr05valores.ParamByName('dt').AsDate :=
    StrToDate(SGresultador05.Cells[2, i]);
  dm.SQLDataSetpesqr05valores.ParamByName('caliq').AsString :=
    SGresultador05.Cells[1, i];
  dm.ClientDataSetpesqr05valores.Open;
  dm.ClientDataSetpesqr05valores.First;
  valor := 0.00;

  for j := 1 to dm.ClientDataSetpesqr05valores.RecordCount do
  begin
    if BcdToDouble(dm.ClientDataSetpesqr05valoresTITEMB.Value) > valor then
    begin
      valor := BcdToDouble(dm.ClientDataSetpesqr05valoresTITEMB.Value);
      id := dm.ClientDataSetpesqr05valoresID_R05_SG.Value;
    end;
    dm.ClientDataSetpesqr05valores.Next;
  end;

  if (valor + StrToFloat(SGresultador05.Cells[3, i])) > 0 then
  begin
    dm.SQLQueryAtualizaValorR05.Close;
    dm.SQLConnection1.Close;
    dm.SQLQueryAtualizaValorR05.sql.Clear;
    sql := 'update r05 set BICMS2=(TITEMB+(:valor)),BICMS7=(TITEMB+(:valor)),VLIQ=(TITEMB+(:valor)),qtde=1,vrunit=(TITEMB+(:valor)),TITEMB=(TITEMB+(:valor)) where id_r05_sg=:id';
    dm.SQLQueryAtualizaValorR05.sql.Text := sql;
    dm.SQLQueryAtualizaValorR05.ParamByName('valor').AsFMTBCD :=
      SGresultador05.Cells[3, i];
    dm.SQLQueryAtualizaValorR05.ParamByName('id').AsInteger := id;
    dm.SQLQueryAtualizaValorR05.ExecSQL(false);
  end
  else
  begin
    // ShowMessage('Erro ao Ratiar Valor Muito Grande'#13 + SGresultador05.Cells[3, i]);
    RatiarNegativoGrandeR05(StrToFloat(SGresultador05.Cells[4, i]),
      SGresultador05.Cells[0, i], StrToDate(SGresultador05.Cells[2, i]),
      SGresultador05.Cells[1, i]);
  end;
end;

procedure TForm1.BtsalvarlbancoClick(Sender: TObject);
var
  config: TIniFile;
begin
  config := TIniFile.Create('.\config.ini');
  config.WriteString('BANCO_DE_DADOS', 'Database', Edlocalbanco.Text);
  config.Free;
  ShowMessage('Ini Alterado');

  Application.Terminate;

end;

procedure TForm1.MarcaCancelado;
var
  sql: String;
  i: Integer;
begin
  dm.ClientDataSetVerificaR04.First;
  for i := 0 to dm.ClientDataSetVerificaR04.RecordCount do
  begin
    dm.SQLQueryAtualizaValorR05.Close;
    dm.SQLQueryAtualizaValorR05.sql.Clear;

    sql := 'update r04 set cancel=''S'' where id_r04=' +
      IntToStr(dm.ClientDataSetVerificaR04ID_R04.Value);
    dm.SQLQueryAtualizaValorR05.sql.Text := sql;
    dm.SQLQueryAtualizaValorR05.ExecSQL(false);
    dm.ClientDataSetVerificaR04.Next;
  end;
  ShowMessage('Cancelamento Processado');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  threadcancel: ThreadMarcaCancelado;
begin
  if dm.ClientDataSetVerificaR04.Active then
  begin
    if dm.ClientDataSetVerificaR04.RecordCount > 0 then
    begin
      threadcancel := ThreadMarcaCancelado.Create(true);
      threadcancel.FreeOnTerminate := true;
      threadcancel.Priority := tpNormal;
      threadcancel.Resume
    end
    else
    begin
      ShowMessage('N�o a Cupons Para Cancelar');
    end;
  end
  else
  begin
    ShowMessage('Primeiro Fa�a a Pesquisa !!');
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form2.Show;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  threadaliq: threadaliquota;
begin
  threadaliq := threadaliquota.Create(true);
  threadaliq.FreeOnTerminate := true;
  threadaliq.Priority := tpHigher;
  threadaliq.Resume;
  TFormenssagem.Lbmenssagem.Caption := 'ATUALIZANDO PRODUTOS VENDIDOS';
  TFormenssagem.Show;
  Form1.Enabled := false;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
PesquisaErro490;//pesquisa erros de 490
end;

procedure TForm1.PesquisaErro490;//pesquisa erros de 490
var
  threadicms: ThreadIcmsDVenda;
begin
  // TFormmenssagem.Show;
  TFormenssagem.Show;
  Form1.Enabled := false;
  threadicms := ThreadIcmsDVenda.Create(true);
  threadicms.FreeOnTerminate := true;
  threadicms.Priority := tpHigher;
  threadicms.Resume;
end;

procedure TForm1.Button5Click(Sender: TObject);

begin
  thread490;
end;

//metodo chama thread que corrige 490
procedure TForm1.thread490;
var
  threadc: threadcorrige490;
begin
      if dm.ClientDataSetVerificaIcms.Active then
  begin
    if dm.ClientDataSetVerificaIcms.RecordCount > 0 then
    begin
      TFormenssagem.Show;
      TFormenssagem.Caption := 'ERRO 490 SENDO CORRIGIDO !!';
      Form1.Enabled := false;
      threadc := threadcorrige490.Create(true);
      threadc.FreeOnTerminate := true;
      threadc.Priority := tpHigher;
      threadc.Resume;
    end
    else
    begin
      ShowMessage('N�o a Erros Para Ser Corrigido !!');
    end;
  end
  else
  begin
    ShowMessage('Primeiro Fa�a a Pesquisa !!');
  end;
end;


procedure TForm1.Corrige490;
var
i :Integer;
begin

dm.ClientDataSetVerificaIcms.First;
  for i := +1 to dm.ClientDataSetVerificaIcms.RecordCount do
  begin
    if dm.ClientDataSetVerificaIcmsDIFERENCA.Value >0 then
    begin
         CorrigePositivo490(dm.ClientDataSetVerificaIcmsNRFAB.Value,dm.ClientDataSetVerificaIcmsEMISSAOD.Value,dm.ClientDataSetVerificaIcmsCALIQ.Value,BcdToDouble(DM.ClientDataSetVerificaIcmsDIFERENCA.Value));

    end else
    begin
        CorrigeNegativo490(dm.ClientDataSetVerificaIcmsNRFAB.Value,dm.ClientDataSetVerificaIcmsEMISSAOD.Value,dm.ClientDataSetVerificaIcmsCALIQ.Value,BcdToDouble(DM.ClientDataSetVerificaIcmsDIFERENCA.Value),BcdToDouble(dm.ClientDataSetVerificaIcmsPROCDIFERENCA.Value));

    end;
    dm.ClientDataSetVerificaIcms.Next;
  end;
  TFormenssagem.close;
  TFormenssagem.Caption := 'PESQUISA SENDO PROCESSADA';
  Form1.Enabled := true;
  PesquisaErro490;
end;

//CORRIGE A DIFERENCA POSITIVA DO 490
procedure TForm1.CorrigePositivo490(serie: String;data: TDate;caliq: String;valor: Double);
  var
  j:Integer;
  id: Integer;
  sql: String;
begin
  dm.SQLConnection1.Close;
  dm.ClientDataSetpesqr05positivo.Close;

  dm.SQLDataSetpesqr05positivo.ParamByName('serie').AsString :=
    serie;
  dm.SQLDataSetpesqr05positivo.ParamByName('dt').AsDate :=
    data;
  dm.SQLDataSetpesqr05positivo.ParamByName('caliq').AsString :=
    caliq;
  dm.ClientDataSetpesqr05positivo.Open;

  dm.ClientDataSetpesqr05positivo.First;
  id := 0;
  for j := 1 to dm.ClientDataSetpesqr05positivo.RecordCount do
  begin
    if BcdToInteger(dm.ClientDataSetpesqr05positivoID_R05_SG.Value) > id then
    begin
      id := BcdToInteger(dm.ClientDataSetpesqr05positivoID_R05_SG.Value);//recebe ultimo id da pesquisa
    end;
    dm.ClientDataSetpesqr05positivo.Next;
  end;

  dm.ClientDataSetpesqr05positivo.Close; // fecha conexao pesquisa positivo;
  dm.SQLQueryAtualizaValorR05.Close;
  dm.SQLConnection1.Close;
  dm.SQLQueryAtualizaValorR05.sql.Clear;
  sql := 'update r05 set BICMS2=(BICMS2+(:valor)),BICMS7=(BICMS7+(:valor)) where id_r05_sg=:id';
  dm.SQLQueryAtualizaValorR05.sql.Text := sql;
  dm.SQLQueryAtualizaValorR05.ParamByName('valor').AsFMTBCD :=
    valor;
  dm.SQLQueryAtualizaValorR05.ParamByName('id').AsString := IntToStr(id);
  dm.SQLQueryAtualizaValorR05.ExecSQL(false);

end;
//CORRIGE A DIFERENCA NEGATIVA DO 490
procedure TForm1.CorrigeNegativo490(serie: String;data: TDate;caliq: String;valor: Double;porce: Double);
var
  j: Integer;
  sql: String;
  id: Integer;
  valortemp:Double;
begin
  dm.SQLConnection1.Close;
  dm.ClientDataSetpesqr05valores490.Close;   //pesquisa o maior valor de item no r05
  dm.SQLDataSetpesqr05valores490.ParamByName('serie').AsString :=
    serie;
  dm.SQLDataSetpesqr05valores490.ParamByName('dt').AsDate :=
    data;
  dm.SQLDataSetpesqr05valores490.ParamByName('caliq').AsString :=
    caliq;
  dm.ClientDataSetpesqr05valores490.Open;

  dm.ClientDataSetpesqr05valores490.First;
 //--------------------------------------------------------------
  valortemp:=0.00;

  for j := 1 to dm.ClientDataSetpesqr05valores490.RecordCount do
  begin  //valortemp e id recebe o maio valor de item do r05
    if BcdToDouble(dm.ClientDataSetpesqr05valores490BICMS2.Value) > valor then
    begin
      valortemp := BcdToDouble(dm.ClientDataSetpesqr05valores490BICMS2.Value);
      id := dm.ClientDataSetpesqr05valores490ID_R05_SG.Value;
    end;
    dm.ClientDataSetpesqr05valores490.Next;
  end;

  if (valortemp + valor) > 0 then
  begin
    dm.SQLQueryAtualizaValorR05.Close;
    dm.SQLConnection1.Close;
    dm.SQLQueryAtualizaValorR05.sql.Clear;
    sql := 'update r05 set BICMS2=(BICMS2+(:valor)),BICMS7=(BICMS7+(:valor)) where id_r05_sg=:id';
    dm.SQLQueryAtualizaValorR05.sql.Text := sql;
    dm.SQLQueryAtualizaValorR05.ParamByName('valor').AsFMTBCD :=
      valor;
    dm.SQLQueryAtualizaValorR05.ParamByName('id').AsInteger := id;
    dm.SQLQueryAtualizaValorR05.ExecSQL(false);
  end
  else
  begin
  //corrige valores de 490 muito grande onde tem que ser pela porcentagem
    RatiarNegativoGrandeR05490 (serie,data,caliq,porce);

  end;
end;

procedure TForm1.RatiarNegativoGrandeR05490 (serie: String;data: TDate;caliq: String;valor: Double);
var
sql: String;
begin
  dm.SQLQueryAtualizaValorR05.Close;
  dm.SQLConnection1.Close;
  dm.SQLQueryAtualizaValorR05.sql.Clear;

  sql := 'update r05 set bicms2=cast(bicms2+bicms2*cast((:porcentagem) as numeric(10,7))/100 as numeric(10,2)),';
  sql := sql +
    'BICMS7=cast(BICMS7+BICMS7*cast((:porcentagem) as numeric(10,7))/100 as numeric(10,2)) ';
   sql := sql +
    'where NRFAB= :serie AND EMISSAOD= :data AND CALIQ= :aliquota and cancel=''N''';

  dm.SQLQueryAtualizaValorR05.sql.Text := sql;
  dm.SQLQueryAtualizaValorR05.ParamByName('porcentagem').AsFloat := valor;

  dm.SQLQueryAtualizaValorR05.ParamByName('serie').AsString := serie;

  dm.SQLQueryAtualizaValorR05.ParamByName('data').AsDate := data;

  dm.SQLQueryAtualizaValorR05.ParamByName('aliquota').AsString := caliq;

  dm.SQLQueryAtualizaValorR05.ExecSQL(false);

end;

procedure TForm1.CalculaIcms;
begin
  dm.SQLConnection1.Close;
  dm.ClientDataSetVerificaIcms.Close;
  dm.SQLDataSetVerificaIcms.ParamByName('dtini').AsDate := Dtinicial.Date;
  dm.SQLDataSetVerificaIcms.ParamByName('dtfin').AsDate := Dtfinal.Date;
  dm.ClientDataSetVerificaIcms.Open;
  TFormenssagem.Close;
  Form1.Enabled := true;
end;

procedure TForm1.AtualizaVenda;
var
  i: Integer;
  sql: String;
begin
  dm.ClientDataSetaliquota.First;
  for i := +1 to dm.ClientDataSetaliquota.RecordCount do
  begin
    // dm.SQLConnection1.Close;
    dm.SQLQueryatualizaaliquota.Close;
    dm.SQLQueryatualizaaliquota.sql.Clear;
    sql := 'UPDATE R05 SET CST_ICMS =:cst where CALIQ =:caliq AND EMISSAOD BETWEEN :dtini AND :dtfin';
    dm.SQLQueryatualizaaliquota.sql.Text := sql;
    if dm.ClientDataSetaliquotaCST.Value = 0 then
    begin
      dm.SQLQueryatualizaaliquota.ParamByName('cst').AsString := '00';
    end
    else
    begin
      dm.SQLQueryatualizaaliquota.ParamByName('cst').AsInteger :=
        dm.ClientDataSetaliquotaCST.Value;
    end;
    dm.SQLQueryatualizaaliquota.ParamByName('caliq').AsString :=
      dm.ClientDataSetaliquotaALIQ.Value;
    dm.SQLQueryatualizaaliquota.ParamByName('dtini').AsDate := Dtinicial.Date;
    dm.SQLQueryatualizaaliquota.ParamByName('dtfin').AsDate := Dtfinal.Date;
    dm.SQLQueryatualizaaliquota.ExecSQL(false);
    dm.ClientDataSetaliquota.Next;
  end;
  TFormenssagem.Lbmenssagem.Caption := 'ATUALIZANDO CFOP';
  AtualizaVendaCFOP(false);
end;

procedure TForm1.AtualizaVendaCFOP(verif: Boolean);
var
  sql: String;

begin
  // dm.SQLConnection1.Close;
  dm.SQLQueryatualizaaliquota.Close;
  dm.SQLQueryatualizaaliquota.sql.Clear;
  sql := 'update R05 set cfop=''5102'' WHERE EMISSAOD BETWEEN :dtini AND :dtfin';
  dm.SQLQueryatualizaaliquota.sql.Text := sql;
  dm.SQLQueryatualizaaliquota.ParamByName('dtini').AsDate := Dtinicial.Date;
  dm.SQLQueryatualizaaliquota.ParamByName('dtfin').AsDate := Dtfinal.Date;
  dm.SQLQueryatualizaaliquota.ExecSQL(false);

  dm.SQLConnection1.Close;
  dm.SQLQueryatualizaaliquota.Close;
  dm.SQLQueryatualizaaliquota.sql.Clear;
  sql := 'update R05 set cfop=''5405'' WHERE CALIQ=''STB'' and EMISSAOD BETWEEN :dtini AND :dtfin';
  dm.SQLQueryatualizaaliquota.sql.Text := sql;
  dm.SQLQueryatualizaaliquota.ParamByName('dtini').AsDate := Dtinicial.Date;
  dm.SQLQueryatualizaaliquota.ParamByName('dtfin').AsDate := Dtfinal.Date;
  dm.SQLQueryatualizaaliquota.ExecSQL(false);

  dm.SQLConnection1.Close;
  dm.SQLQueryatualizaaliquota.Close;
  dm.SQLQueryatualizaaliquota.sql.Clear;
  sql := 'update R05 SET CST_ICMS=''40'' where CALIQ=''IST'' AND EMISSAOD BETWEEN :dtini AND :dtfin';
  dm.SQLQueryatualizaaliquota.sql.Text := sql;
  dm.SQLQueryatualizaaliquota.ParamByName('dtini').AsDate := Dtinicial.Date;
  dm.SQLQueryatualizaaliquota.ParamByName('dtfin').AsDate := Dtfinal.Date;
  dm.SQLQueryatualizaaliquota.ExecSQL(false);

  dm.SQLConnection1.Close;
  dm.SQLQueryatualizaaliquota.Close;
  dm.SQLQueryatualizaaliquota.sql.Clear;
  sql := 'update R05 SET CST_ICMS=''60'' where CALIQ=''STB'' AND EMISSAOD BETWEEN :dtini AND :dtfin';
  dm.SQLQueryatualizaaliquota.sql.Text := sql;
  dm.SQLQueryatualizaaliquota.ParamByName('dtini').AsDate := Dtinicial.Date;
  dm.SQLQueryatualizaaliquota.ParamByName('dtfin').AsDate := Dtfinal.Date;
  dm.SQLQueryatualizaaliquota.ExecSQL(false);
  if verif then
    ShowMessage('ATUALIZADO COM SUCESSO');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  AtualizaVendaCFOP(true);
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  threadvc: ThreadVendaCancelado;
begin

  threadvc := ThreadVendaCancelado.Create(true);
  threadvc.FreeOnTerminate := true;
  threadvc.Priority := tpHigher;
  threadvc.Resume;
  TFormenssagem.Show;
  Form1.Enabled := false;
end;

procedure TForm1.Button8Click(Sender: TObject);
VAR
S:STRING;
begin
  IdFTP1.Disconnect;
  IdFTP1.Host := 'ftp.atmatech.com.br';
  IdFTP1.Port := 21;
  IdFTP1.Username := 'atmatech';
  IdFTP1.Password := 'atma2013';
  IdFTP1.Passive := false; // usa modo ativo
  try
    // Espera at� 10 segundos pela conex�o
    IdFTP1.Connect;
    IdFTP1.Get('Web/setup.exe', 'setup.exe', true, false);
    IdFTP1.Quit;
    ShowMessage('Download Efetuado Com Sucesso');
  except
    on E: Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TForm1.VendaCancelado;
begin
  // dm.SQLConnection1.Close;
  dm.ClientDataSetVendasSemR02.Close;
  dm.SQLDataSetVendasSemR02.ParamByName('dtini').AsDate := Dtinicial.Date;
  dm.SQLDataSetVendasSemR02.ParamByName('dtfin').AsDate := Dtfinal.Date;
  dm.ClientDataSetVendasSemR02.Open;
  pesquisacancelado;
  LbtTotalizadoresDivergentes.Caption := 'Pesquisa sendo Processada';
  TotalizadoresDivergentes;
  TFormenssagem.Close;
  Form1.Enabled := true;
end;

procedure TForm1.RatiarNegativoGrandeR05(porcentagem: Double; serie: String;
  Data: TDate; aliquota: String);
var
  sql: string;

begin

  dm.SQLQueryAtualizaValorR05.Close;
  dm.SQLConnection1.Close;
  dm.SQLQueryAtualizaValorR05.sql.Clear;

  sql := 'update r05 set bicms2=cast(bicms2+bicms2*cast((:porcentagem) as numeric(10,7))/100 as numeric(10,2)),';
  sql := sql +
    'BICMS7=cast(BICMS7+BICMS7*cast((:porcentagem) as numeric(10,7))/100 as numeric(10,2)),';
  sql := sql +
    'VLIQ=cast(VLIQ+VLIQ*cast((:porcentagem) as numeric(10,7))/100 as numeric(10,2)),';
  sql := sql +
    'vrunit=cast(vrunit+vrunit*cast((:porcentagem) as numeric(10,7))/100 as numeric(10,2)),';
  sql := sql +
    'TITEMB=cast(TITEMB+TITEMB*cast((:porcentagem) as numeric(10,7))/100 as numeric(10,2))';
  sql := sql +
    'where NRFAB= :serie AND EMISSAOD= :data AND CALIQ= :aliquota and cancel=''N''';

  dm.SQLQueryAtualizaValorR05.sql.Text := sql;
  dm.SQLQueryAtualizaValorR05.ParamByName('porcentagem').AsFloat := porcentagem;
  // StrToFloat(SGresultador05.Cells[4, i]);

  dm.SQLQueryAtualizaValorR05.ParamByName('serie').AsString := serie;
  // SGresultador05.Cells[0, i];

  dm.SQLQueryAtualizaValorR05.ParamByName('data').AsDate := Data;
  // StrToDate(SGresultador05.Cells[2, i]);

  dm.SQLQueryAtualizaValorR05.ParamByName('aliquota').AsString := aliquota;
  // SGresultador05.Cells[1, i];

  dm.SQLQueryAtualizaValorR05.ExecSQL(false);

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  config: TIniFile;
  nome_bd: String;
  Data: sTRING;
begin
  Dtinicial.Date := Date;
  Dtfinal.Date := Date;
  PageControl2.ActivePage := TabSheet3;
  Form1.Caption := Form1.Caption + ' Beta: 1.0.25';
  SGresultador05.Cells[0, 0] := 'ECF';
  SGresultador05.ColWidths[0] := 130;
  SGresultador05.Cells[1, 0] := 'ALIQUOTA';
  SGresultador05.Cells[2, 0] := 'DATA';
  SGresultador05.Cells[3, 0] := 'VALOR';
  SGresultador05.Cells[4, 0] := 'PORC';
  SGresultador05.ColWidths[4] := 60;

  SGtotalcancel.Cells[0, 0] := 'ECF';
  SGtotalcancel.ColWidths[0] := 130;
  SGtotalcancel.Cells[1, 0] := 'DATA';
  SGtotalcancel.Cells[2, 0] := 'TOTAL DE CANCELADOS';
  SGtotalcancel.ColWidths[2] := 130;

  // se nao existir arquivo ele cria
  if not FileExists('.\config.ini') then
  begin
    config := TIniFile.Create('.\config.ini');
    config.WriteString('BANCO_DE_DADOS', 'Database', '');
    config.WriteString('BANCO_DE_DADOS', 'User_Name', 'SYSDBA');
    config.WriteString('BANCO_DE_DADOS', 'Password', 'masterkey');
    config.Free;
    ShowMessage('Arquivo ini criado');
  end;

  // se existir ele le
  if FileExists('.\config.ini') then
  begin
    config := TIniFile.Create('.\config.ini');
    nome_bd := config.ReadString('BANCO_DE_DADOS', 'database', '');

    Edlocalbanco.Text := nome_bd;
    config.Free;
  end;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
//CHAMA FORMULARIO DE LOGIM
  Formlogin := TFormlogin.Create(NIL);
  Formlogin.Caption:=Form1.Caption;
  Formlogin.ShowModal;

  try     //VERIFICA SE FOI POSSIVEL CONECTAR A BANCO
    dm.ClientDataSetaliquota.Open;
  except
    on E: Exception do
      ShowMessage('N�o Foi Possivel a Se Conectar ao Banco');
  end;


  //CHAMA FORMULARIO DAS MUDANCAS DA VERSAO
  FormVersao := TFormVersao.Create(NIL);
  FormVersao.Caption := Form1.Caption;
  FormVersao.Show;
end;

end.
