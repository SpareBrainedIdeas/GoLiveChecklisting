codeunit 76005 "GLC Demo Result"
{
    Subtype = Test;

    trigger OnRun()
    var
        GLCResultHandler: Codeunit "GLC Result Handler";
        i: Integer;
    begin
        for i := 1 to Random(100) do begin
            GLCResultHandler.CacheResult('Test Passed');
        end;
    end;
}
