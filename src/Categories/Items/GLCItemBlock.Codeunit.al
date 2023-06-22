codeunit 76051 "GLC Item Block"
{
    Subtype = Test;

    trigger OnRun()
    var
        Item: Record Item;
        GLCResultHandler: Codeunit "GLC Result Handler";
        ExpectedUnblockedItems: Integer;
        ExpectedBlockedItems: Integer;
        ActualUnblockedItems: Integer;
        ActualBlockedItems: Integer;
    begin
        ExpectedBlockedItems := 1;
        ExpectedUnblockedItems := 20;

        Item.SetRange(Blocked, false);
        ActualUnblockedItems := Item.Count;

        Item.SetRange(Blocked, true);
        ActualBlockedItems := Item.Count;

        if (ActualBlockedItems <> ExpectedBlockedItems) then
            GLCResultHandler.CacheError(StrSubstNo('Expected %1 blocked Items, but found %2.', ExpectedBlockedItems, ActualBlockedItems))
        else
            GLCResultHandler.CacheResult('Correct number of Expected blocked Items');
        if (ActualUnblockedItems <> ExpectedUnblockedItems) then
            GLCResultHandler.CacheError(StrSubstNo('Expected %1 unblocked Items, but found %2.', ExpectedUnblockedItems, ActualUnblockedItems))
        else
            GLCResultHandler.CacheResult('Correct number of Expected unblocked Items');
    end;
}
