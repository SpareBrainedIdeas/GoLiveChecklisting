codeunit 76011 "GLC GL Validate Acc. Type"
{
    Subtype = Test;

    trigger OnRun()
    var
        GLAccount: Record "G/L Account";
        GLAccount2: Record "G/L Account";
        GLCResultHandler: Codeunit "GLC Result Handler";
        LastBalanceSheetNo: Code[20];
        FirstIncomeStatementNo: Code[20];
    begin
        // This is hard-coded but could be done with clever parameter handling.
        LastBalanceSheetNo := '5999';
        FirstIncomeStatementNo := '6000'; // First Income Statement type

        GLAccount2.Reset();
        if GLAccount.FindSet() then
            repeat
                if not CheckAccountSetting(GLAccount, LastBalanceSheetNo, FirstIncomeStatementNo) then
                    GLCResultHandler.CacheError(GetLastErrorText())
                else
                    GLCResultHandler.CacheResult(StrSubstNo('%1 is correctly configured. (%2-%3)', GLAccount."No."));
            until GLAccount.Next() < 1;
    end;

    [TryFunction]
    local procedure CheckAccountSetting(var GLAccount: Record "G/L Account"; var LastBalanceSheetNo: Code[20]; var FirstIncomeStatementNo: Code[20])
    var
        GLAccount2: Record "G/L Account";
    begin
        if GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Balance Sheet" then begin
            GLAccount2.FilterGroup(10);
            GLAccount2.SetFilter("No.", '..%1', LastBalanceSheetNo);
            GLAccount2.FilterGroup(0);
            GLAccount2.SetFilter("No.", '%1', GLAccount."No.");
            if GLAccount2.IsEmpty then
                Error('Account %1 is before %2, which means it should be a Balance Sheet account.', GLAccount."No.", LastBalanceSheetNo);
        end else begin
            GLAccount2.FilterGroup(10);
            GLAccount2.SetFilter("No.", '%1..', FirstIncomeStatementNo);
            GLAccount2.FilterGroup(0);
            GLAccount2.SetFilter("No.", '%1', GLAccount."No.");
            if GLAccount2.IsEmpty then
                Error('Account %1 is after %2, which means it should be an Income Statement account.', GLAccount."No.", FirstIncomeStatementNo);
        end;
    end;
}
