unit uPrinc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  MemDS, DBAccess, Ora, StdCtrls, ExtCtrls, DBCtrls, ComCtrls, OdacVcl;

const   maxWidth = 352;
        maxHeight = 230;

type
  TForm1 = class(TForm)
    oSession: TOraSession;
    qryFotos: TOraQuery;
    qryFotosCOD_FUNC: TFloatField;
    qryFotosFOTO_FUNC: TBlobField;
    btIniciar: TButton;
    DBImage1: TDBImage;
    DataSource1: TDataSource;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbTot: TLabel;
    lbAtu: TLabel;
    ConnectDialog1: TConnectDialog;
    Label4: TLabel;
    edLim: TEdit;
    Label5: TLabel;
    edCod: TEdit;
    procedure btIniciarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edLimChange(Sender: TObject);
  private
    { Private declarations }
    procedure habilitaIniciar;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.btIniciarClick(Sender: TObject);
var thumbRect : TRect;
    totFotos, totAjustadas : integer;
    mensagem : string;
begin
  qryFotos.ParamByName('INICIO').AsInteger := strtoint(edCod.Text);
  qryFotos.Open;
  totFotos := 0;
  totAjustadas := 0;
  mensagem := 'Não existem registros para serem processado!';
  while (not qryFotos.Eof) and
        (totFotos < strtoint(edLim.Text)) do
  begin
    if not qryFotos.FieldByName('FOTO_FUNC').IsNull then
    begin
      try
        // REDIMENSIONA O BITMAP PROPORCIONALMENTE
        thumbRect.Left := 0;
        thumbRect.Top := 0;
        Form1.Update;
        if dbImage1.Picture.Bitmap.Width > dbImage1.Picture.Bitmap.Height then
        begin
          if dbImage1.Picture.Bitmap.Width > maxWidth then
          begin
            thumbRect.Right := maxWidth;
            thumbRect.Bottom := (maxWidth * dbImage1.Picture.Bitmap.Height) div dbImage1.Picture.Bitmap.Width;
            qryFotos.Edit;
            dbImage1.Picture.Bitmap.Canvas.StretchDraw(thumbRect, dbImage1.Picture.Bitmap) ;
            dbImage1.Picture.Bitmap.Width := thumbRect.Right;
            dbImage1.Picture.Bitmap.Height := thumbRect.Bottom;
            qryFotos.Post;
            inc(totAjustadas);
          end;
        end
        else
        begin
          if dbImage1.Picture.Bitmap.Height > maxHeight then
          begin
            thumbRect.Bottom := maxHeight;
            thumbRect.Right := (maxHeight * dbImage1.Picture.Bitmap.Width) div dbImage1.Picture.Bitmap.Height;
            qryFotos.Edit;
            dbImage1.Picture.Bitmap.Canvas.StretchDraw(thumbRect, dbImage1.Picture.Bitmap) ;
            dbImage1.Picture.Bitmap.Width := thumbRect.Right;
            dbImage1.Picture.Bitmap.Height := thumbRect.Bottom;
            qryFotos.Post;
            inc(totAjustadas);
          end;
        end;
      finally
      end;
    end;
    inc(totFotos);
    lbTot.Caption := inttostr(totFotos);
    lbAtu.Caption := inttostr(totAjustadas);
    mensagem := 'Último código processado -> ' + qryFotosCOD_FUNC.AsString;
    qryFotos.Next;
  end;
  qryFotos.Close;
  MessageDlg('Processo concluído com sucesso!' + #13 + #13 +
             'Total de Fotos: ' + inttostr(totFotos) + #13 +
             'Total de Fotos Ajustadas: ' + inttostr(totAjustadas) + #13 + #13 +
             mensagem, mtInformation, [mbOK], 0);
  Form1.Close;
end;

procedure TForm1.edLimChange(Sender: TObject);
begin
  habilitaIniciar;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  oSession.Connected := true;
end;

procedure TForm1.habilitaIniciar;
begin
  btIniciar.Enabled := false;
  try
    strtoint(edLim.Text);
    strtoint(edCod.Text);
    btIniciar.Enabled := true;
  except
  end;
end;

end.
