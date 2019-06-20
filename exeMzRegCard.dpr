program exeMzRegCard;

uses
  Forms,
  uMzRegCard in 'uMzRegCard.pas' {FCRMHistory};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMzRegCard, FMzRegCard);
  Application.Run;
end.
