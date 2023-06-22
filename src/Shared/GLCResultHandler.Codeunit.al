codeunit 76003 "GLC Result Handler"
{
    SingleInstance = true;

    var
        ResultList: List of [Text];
        ErrorList: List of [Text];

    procedure CacheResult(ResultText: Text)
    begin
        ResultList.Add(ResultText);
    end;

    procedure GetResults(): List of [Text]
    begin
        exit(ResultList);
    end;

    procedure CacheError(ErrorText: Text)
    begin
        ErrorList.Add(ErrorText);
    end;

    procedure GetErrors(): List of [Text]
    begin
        exit(ErrorList);
    end;

    internal procedure ClearData()
    begin
        Clear(ResultList);
        Clear(ErrorList);
    end;
}
