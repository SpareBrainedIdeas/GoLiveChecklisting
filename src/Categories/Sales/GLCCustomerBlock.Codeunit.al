codeunit 76021 "GLC Customer Block"
{
    Subtype = Test;

    trigger OnRun()
    var
        Customer: Record Customer;
        GLCResultHandler: Codeunit "GLC Result Handler";
        ExpectedUnblockedCustomers: Integer;
        ExpectedBlockedCustomers: Integer;
        ActualUnblockedCustomers: Integer;
        ActualBlockedCustomers: Integer;
    begin
        ExpectedBlockedCustomers := 10;
        ExpectedUnblockedCustomers := 100;

        Customer.SetRange(Blocked, Customer.Blocked::" ");
        ActualUnblockedCustomers := Customer.Count;

        Customer.SetFilter(Blocked, '<>%1', Customer.Blocked::" ");
        ActualBlockedCustomers := Customer.Count;

        if (ActualBlockedCustomers <> ExpectedBlockedCustomers) then
            GLCResultHandler.CacheError(StrSubstNo('Expected %1 blocked Customers, but found %2.', ExpectedBlockedCustomers, ActualBlockedCustomers))
        else
            GLCResultHandler.CacheResult('Correct number of Expected blocked Customers');
        if (ActualUnblockedCustomers <> ExpectedUnblockedCustomers) then
            GLCResultHandler.CacheError(StrSubstNo('Expected %1 unblocked Customers, but found %2.', ExpectedUnblockedCustomers, ActualUnblockedCustomers))
        else
            GLCResultHandler.CacheResult('Correct number of Expected unblocked Customers');
    end;
}
