unit Udm;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.DB, Datasnap.Provider,
  Datasnap.DBClient, Data.SqlExpr, Data.FMTBcd, Data.DBXInterBase, IniFiles;

type
  Tdm = class(TDataModule)
    DataSetProvider1: TDataSetProvider;
    DataSource1: TDataSource;
    SQLDataSet1: TSQLDataSet;
    ClientDataSet1: TClientDataSet;
    DataSource2: TDataSource;
    ClientDataSet2: TClientDataSet;
    DataSetProvider2: TDataSetProvider;
    SQLDataSet2: TSQLDataSet;
    SQLConnection1: TSQLConnection;
    SQLDataSet1NRFAB: TStringField;
    SQLDataSet1TPARCIAL: TStringField;
    SQLDataSet1EMISSAOD: TDateField;
    SQLDataSet1SUM: TFMTBCDField;
    ClientDataSet1NRFAB: TStringField;
    ClientDataSet1TPARCIAL: TStringField;
    ClientDataSet1EMISSAOD: TDateField;
    ClientDataSet1SUM: TFMTBCDField;
    SQLDataSet2NRFAB: TStringField;
    SQLDataSet2TPARCIAL: TStringField;
    SQLDataSet2CALIQ: TStringField;
    SQLDataSet2EMISSAOD: TDateField;
    ClientDataSet2NRFAB: TStringField;
    ClientDataSet2TPARCIAL: TStringField;
    ClientDataSet2CALIQ: TStringField;
    ClientDataSet2EMISSAOD: TDateField;
    DataSetProviderAtualizaValorR05: TDataSetProvider;
    ClientDataSetRatiarMaior5: TClientDataSet;
    SQLQueryAtualizaValorR05: TSQLQuery;
    SQLDataSetVerificaR04: TSQLDataSet;
    DataSetProviderVerificaR04: TDataSetProvider;
    ClientDataSetVerificaR04: TClientDataSet;
    SQLDataSetVerificaR04NRFAB: TStringField;
    SQLDataSetVerificaR04EMISSAOD: TDateField;
    SQLDataSetVerificaR04COO: TIntegerField;
    SQLDataSetVerificaR04KONT: TLargeintField;
    ClientDataSetVerificaR04NRFAB: TStringField;
    ClientDataSetVerificaR04EMISSAOD: TDateField;
    ClientDataSetVerificaR04COO: TIntegerField;
    ClientDataSetVerificaR04KONT: TLargeintField;
    DataSourceVerificaR04: TDataSource;
    ClientDataSetPesqr05: TClientDataSet;
    DataSetProviderPesqr05: TDataSetProvider;
    SQLDataSetPesqr05: TSQLDataSet;
    SQLDataSetPesqr05ID_R05_SG: TIntegerField;
    SQLDataSetPesqr05TITEMB: TFMTBCDField;
    ClientDataSetPesqr05ID_R05_SG: TIntegerField;
    ClientDataSetPesqr05TITEMB: TFMTBCDField;
    DataSetProviderpesqr05positivo: TDataSetProvider;
    ClientDataSetpesqr05positivo: TClientDataSet;
    DataSourcepesqr05positivo: TDataSource;
    SQLDataSetpesqr05positivo: TSQLDataSet;
    SQLDataSetpesqr05positivoID_R05_SG: TIntegerField;
    SQLDataSetpesqr05positivoBICMS2: TFMTBCDField;
    SQLDataSetpesqr05positivoBICMS7: TFMTBCDField;
    SQLDataSetpesqr05positivoVLIQ: TFMTBCDField;
    SQLDataSetpesqr05positivoQTDE: TFMTBCDField;
    SQLDataSetpesqr05positivoVRUNIT: TFMTBCDField;
    SQLDataSetpesqr05positivoTITEMB: TFMTBCDField;
    SQLDataSetpesqr05positivoCANCEL: TStringField;
    ClientDataSetpesqr05positivoID_R05_SG: TIntegerField;
    ClientDataSetpesqr05positivoBICMS2: TFMTBCDField;
    ClientDataSetpesqr05positivoBICMS7: TFMTBCDField;
    ClientDataSetpesqr05positivoVLIQ: TFMTBCDField;
    ClientDataSetpesqr05positivoQTDE: TFMTBCDField;
    ClientDataSetpesqr05positivoVRUNIT: TFMTBCDField;
    ClientDataSetpesqr05positivoTITEMB: TFMTBCDField;
    ClientDataSetpesqr05positivoCANCEL: TStringField;
    DataSourcepesqr05valores: TDataSource;
    ClientDataSetpesqr05valores: TClientDataSet;
    DataSetProviderpesqr05valores: TDataSetProvider;
    SQLDataSetpesqr05valores: TSQLDataSet;
    SQLDataSetpesqr05valoresID_R05_SG: TIntegerField;
    SQLDataSetpesqr05valoresBICMS2: TFMTBCDField;
    SQLDataSetpesqr05valoresBICMS7: TFMTBCDField;
    SQLDataSetpesqr05valoresVLIQ: TFMTBCDField;
    SQLDataSetpesqr05valoresQTDE: TFMTBCDField;
    SQLDataSetpesqr05valoresVRUNIT: TFMTBCDField;
    SQLDataSetpesqr05valoresTITEMB: TFMTBCDField;
    ClientDataSetpesqr05valoresID_R05_SG: TIntegerField;
    ClientDataSetpesqr05valoresBICMS2: TFMTBCDField;
    ClientDataSetpesqr05valoresBICMS7: TFMTBCDField;
    ClientDataSetpesqr05valoresVLIQ: TFMTBCDField;
    ClientDataSetpesqr05valoresQTDE: TFMTBCDField;
    ClientDataSetpesqr05valoresVRUNIT: TFMTBCDField;
    ClientDataSetpesqr05valoresTITEMB: TFMTBCDField;
    SQLDataSetVerificaR04VTLIQ: TFMTBCDField;
    SQLDataSetVerificaR04CANCEL: TStringField;
    SQLDataSetVerificaR04ID_R04: TIntegerField;
    ClientDataSetVerificaR04VTLIQ: TFMTBCDField;
    ClientDataSetVerificaR04CANCEL: TStringField;
    ClientDataSetVerificaR04ID_R04: TIntegerField;
    DataSetProvideraliquota: TDataSetProvider;
    ClientDataSetaliquota: TClientDataSet;
    DataSourcealiquota: TDataSource;
    SQLDataSetaliquota: TSQLDataSet;
    SQLQueryatualizaaliquota: TSQLQuery;
    DataSetProvideratualizaaliquota: TDataSetProvider;
    ClientDataSetatualizaaliquota: TClientDataSet;
    DataSourceatualizaaliquota: TDataSource;
    SQLDataSet2CAST: TFMTBCDField;
    ClientDataSet2CAST: TFMTBCDField;
    SQLDataSetVerificaIcms: TSQLDataSet;
    DataSetProviderVerificaIcms: TDataSetProvider;
    ClientDataSetVerificaIcms: TClientDataSet;
    DataSourceVerificaIcms: TDataSource;
    SQLDataSetaliquotaCST: TIntegerField;
    SQLDataSetaliquotaALIQ: TStringField;
    SQLDataSetaliquotaICM_EF: TFMTBCDField;
    ClientDataSetaliquotaCST: TIntegerField;
    ClientDataSetaliquotaALIQ: TStringField;
    ClientDataSetaliquotaICM_EF: TFMTBCDField;
    SQLQueryajustetotalizadores: TSQLQuery;
    DataSetProviderajustetotalizadores: TDataSetProvider;
    ClientDataSetajustetotalizadores: TClientDataSet;
    SQLDataSetVendasSemR02: TSQLDataSet;
    DataSetProviderVendasSemR02: TDataSetProvider;
    ClientDataSetVendasSemR02: TClientDataSet;
    DataSourceVendasSemR02: TDataSource;
    SQLDataSetVendasSemR02NS20: TStringField;
    SQLDataSetVendasSemR02NROCAIXA: TIntegerField;
    SQLDataSetVendasSemR02DATAMOV: TDateField;
    SQLDataSetVendasSemR02KONT: TLargeintField;
    ClientDataSetVendasSemR02NS20: TStringField;
    ClientDataSetVendasSemR02NROCAIXA: TIntegerField;
    ClientDataSetVendasSemR02DATAMOV: TDateField;
    ClientDataSetVendasSemR02KONT: TLargeintField;
    SQLDataSetAliquotasDiferente: TSQLDataSet;
    DataSetProviderAliquotasDiferente: TDataSetProvider;
    ClientDataSetAliquotasDiferente: TClientDataSet;
    DataSourceAliquotasDiferente: TDataSource;
    SQLDataSetAliquotasDiferenteNRFAB: TStringField;
    SQLDataSetAliquotasDiferenteEMISSAOD: TDateField;
    SQLDataSetAliquotasDiferenteNR_TOT: TStringField;
    SQLDataSetAliquotasDiferenteCALIQ: TStringField;
    ClientDataSetAliquotasDiferenteNRFAB: TStringField;
    ClientDataSetAliquotasDiferenteEMISSAOD: TDateField;
    ClientDataSetAliquotasDiferenteNR_TOT: TStringField;
    ClientDataSetAliquotasDiferenteCALIQ: TStringField;
    SQLDataSetAliquotasDiferenteID_R05_SG: TIntegerField;
    ClientDataSetAliquotasDiferenteID_R05_SG: TIntegerField;
    SQLDataSetVerificaIcmsNRFAB: TStringField;
    SQLDataSetVerificaIcmsCALIQ: TStringField;
    SQLDataSetVerificaIcmsTPARCIAL: TStringField;
    SQLDataSetVerificaIcmsEMISSAOD: TDateField;
    SQLDataSetVerificaIcmsSOMABICM: TFMTBCDField;
    SQLDataSetVerificaIcmsSOMAITEM: TFMTBCDField;
    ClientDataSetVerificaIcmsNRFAB: TStringField;
    ClientDataSetVerificaIcmsCALIQ: TStringField;
    ClientDataSetVerificaIcmsTPARCIAL: TStringField;
    ClientDataSetVerificaIcmsEMISSAOD: TDateField;
    ClientDataSetVerificaIcmsSOMABICM: TFMTBCDField;
    ClientDataSetVerificaIcmsSOMAITEM: TFMTBCDField;
    SQLDataSetVerificaIcmsDIFERENCA: TFMTBCDField;
    ClientDataSetVerificaIcmsDIFERENCA: TFMTBCDField;
    SQLDataSetVerificaIcmsPROCDIFERENCA: TFMTBCDField;
    ClientDataSetVerificaIcmsPROCDIFERENCA: TFMTBCDField;
    SQLDataSetpesqr05valores490: TSQLDataSet;
    SQLDataSetpesqr05valores490ID_R05_SG: TIntegerField;
    SQLDataSetpesqr05valores490BICMS2: TFMTBCDField;
    SQLDataSetpesqr05valores490BICMS7: TFMTBCDField;
    SQLDataSetpesqr05valores490VLIQ: TFMTBCDField;
    SQLDataSetpesqr05valores490QTDE: TFMTBCDField;
    SQLDataSetpesqr05valores490VRUNIT: TFMTBCDField;
    SQLDataSetpesqr05valores490TITEMB: TFMTBCDField;
    DataSetProviderpesqr05positivo490: TDataSetProvider;
    ClientDataSetpesqr05valores490: TClientDataSet;
    ClientDataSetpesqr05valores490ID_R05_SG: TIntegerField;
    ClientDataSetpesqr05valores490BICMS2: TFMTBCDField;
    ClientDataSetpesqr05valores490BICMS7: TFMTBCDField;
    ClientDataSetpesqr05valores490VLIQ: TFMTBCDField;
    ClientDataSetpesqr05valores490QTDE: TFMTBCDField;
    ClientDataSetpesqr05valores490VRUNIT: TFMTBCDField;
    ClientDataSetpesqr05valores490TITEMB: TFMTBCDField;
    procedure SQLConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{ %CLASSGROUP 'System.Classes.TPersistent' }

{$R *.dfm}

procedure Tdm.SQLConnection1BeforeConnect(Sender: TObject);
var
  config: TIniFile;
begin
  try
    config := TIniFile.Create('.\config.ini');
    dm.SQLConnection1.Params.Values['Database'] :=
      config.ReadString('BANCO_DE_DADOS', 'database', '');
    config.Free;
  except
    on E: Exception do
  end;

end;

end.
