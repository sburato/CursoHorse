unit Views.Perfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, Services.Perfil, FMX.MultiView;

type
  TFrmPerfil = class(TFrmBaseView)
    retContent: TRectangle;
    lytHeader: TLayout;
    lytUsuario: TLayout;
    lytTelefone: TLayout;
    lblUsuario: TLabel;
    txtUsuario: TLabel;
    Label1: TLabel;
    txtTelefone: TLabel;
    imgPerfil: TCircle;
    txtNome: TLabel;
    txtSexo: TLabel;
    btnTrocarFoto: TButton;
    imgMenu: TPath;
    MultiView: TMultiView;
    retContentMultiView: TRectangle;
    btnGaleria: TButton;
    imgGaleria: TPath;
    lblGaleria: TLabel;
    btnCamera: TButton;
    imgCamera: TPath;
    lblCamera: TLabel;
    OpenDialog: TOpenDialog;
    procedure btnGaleriaClick(Sender: TObject);
  private
    FService: TServicePerfil;
    procedure OnChangeProfileImage(const ABitmap: TBitmap);
  public
    constructor Create(AOwner: TComponent); override;
    procedure CarregarFotoUsuario;
  end;

implementation

{$R *.fmx}

{ TFrmPerfil }

constructor TFrmPerfil.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FService := TServicePerfil.Create(Self);

  txtNome.Text     := Session.User.Nome;
  txtSexo.Text     := Session.User.GetSexoAsString();
  txtTelefone.Text := Session.User.Telefone;
  txtUsuario.Text  := Session.User.Login;

  MultiView.Height := 100;
  Self.CarregarFotoUsuario();
end;

procedure TFrmPerfil.OnChangeProfileImage(const ABitmap: TBitmap);
var
  LFoto: TMemoryStream;
begin
  LFoto := TMemoryStream.Create;
  try
    ABitmap.SaveToStream(LFoto);
    LFoto.Position := 0;

    if (LFoto.Size > 0) then
    begin
      imgPerfil.Fill.Bitmap.Bitmap.LoadFromStream(LFoto);
    end;

    LFoto.Position := 0;
    FService.UploadFoto(LFoto);
  finally
    LFoto.Free;
  end;
end;

procedure TFrmPerfil.btnGaleriaClick(Sender: TObject);
begin
  inherited;
  {$IFDEF MSWINDOWS}
    if (OpenDialog.Execute) then
    begin
      Self.OnChangeProfileImage(TBitmap.CreateFromFile(OpenDialog.FileName));
    end;
  {$ENDIF}

  {$IFDEF ANDROID}
  {$ENDIF}

  MultiView.HideMaster;
end;

procedure TFrmPerfil.CarregarFotoUsuario;
var
  LFoto: TMemoryStream;
begin
  LFoto := FService.DownloadFoto();
  try
    if (LFoto.Size > 0) then
    begin
      imgPerfil.Fill.Bitmap.Bitmap.LoadFromStream(LFoto);
    end;
  finally
    LFoto.Free;
  end;
end;

end.
