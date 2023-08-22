unit Providers.Models.Token;

interface

type
  TToken = class
  private
    FAccess : String;
    FRefresh: String;
  public
    property Access : String read FAccess   write FAccess;
    property Refresh: String read FRefresh write FRefresh;
  end;

implementation

end.
