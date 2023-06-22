codeunit 76000 "GLC Check Runner"
{
    Subtype = TestRunner;

    var
        CategoryIdFilter: Text;
        SubcategoryIdFilter: Text;

    trigger OnRun()
    var
        GLCCategory: Record "GLC Category";
    begin
        DeletePriorResults(0, 0);

        if CategoryIdFilter <> '' then
            GLCCategory.SetFilter(Id, CategoryIdFilter);
        if GLCCategory.FindSet() then
            repeat
                RunForCategory(GLCCategory, false);
            until GLCCategory.Next() < 1;
    end;

    procedure RunForCategory(GLCCategory: Record "GLC Category"; ClearPriorResults: Boolean)
    var
        GLCSubcategory: Record "GLC Subcategory";
    begin
        GLCSubcategory.SetRange("Category Id", GLCCategory.Id);
        if SubcategoryIdFilter <> '' then
            GLCSubcategory.SetFilter(Id, SubcategoryIdFilter);
        if GLCSubcategory.FindSet() then
            repeat
                RunForSubcategory(GLCSubcategory, false);
                GLCSubcategory."Last Run Date" := today();
                GLCSubcategory.Modify(true);
            until GLCSubcategory.Next() < 1;
    end;

    procedure RunForSubcategory(GLCSubcategory: Record "GLC Subcategory"; ClearPriorResults: Boolean)
    var
        GLCTestStep: Record "GLC Test Step";
        GLCResultHandler: Codeunit "GLC Result Handler";
    begin
        GLCTestStep.SetRange("Category Id", GLCSubcategory."Category Id");
        GLCTestStep.SetRange("Subcategory Id", GLCSubcategory.Id);
        GLCTestStep.SetFilter("Test Codeunit Id", '<>0');
        if GLCTestStep.FindSet() then
            repeat
                if not Codeunit.Run(GLCTestStep."Test Codeunit Id") then
                    GLCResultHandler.CacheError(StrSubstNo('Error while running test: %1', GetLastErrorText()));
                LogResults(GLCTestStep);
            until GLCTestStep.Next() = 0;
    end;

    procedure SetCategoryFilter(GLCCategory: Record "GLC Category")
    begin
        CategoryIdFilter := GLCCategory.GetFilter(Id);
    end;

    procedure SetSubcategoryFilter(GLCSubcategory: Record "GLC Subcategory")
    begin
        SubcategoryIdFilter := GLCSubcategory.GetFilter(Id);
    end;

    procedure DeletePriorResults(CategoryId: Integer; SubcategoryId: Integer)
    var
        GLCTestResult: Record "GLC Test Result";
    begin
        if CategoryId <> 0 then
            GLCTestResult.SetRange("Category Id", CategoryId);
        if SubcategoryId <> 0 then
            GLCTestResult.SetRange("Subcategory Id", SubcategoryId);
        GLCTestResult.DeleteAll();
    end;

    local procedure LogResults(var GLCTestStep: Record "GLC Test Step")
    var
        GLCTestResult: Record "GLC Test Result";
        GLCResultHandler: Codeunit "GLC Result Handler";
        ResultList: List of [Text];
        ErrorList: List of [Text];
        ThisResult: Text;
        ThisError: Text;
        NextResultNo: Integer;
    begin
        ResultList := GLCResultHandler.GetResults();
        ErrorList := GLCResultHandler.GetErrors();

        NextResultNo := 1;
        foreach ThisResult in ResultList do begin
            GLCTestResult.Init();
            GLCTestResult.TransferFields(GLCTestStep, true);
            GLCTestResult.Id := NextResultNo;
            NextResultNo += 1;
            GLCTestResult."Result Type" := GLCTestResult."Result Type"::Success;
            GLCTestResult."Result Text" := CopyStr(ThisResult, 1, MaxStrLen(GLCTestResult."Result Text"));
            GLCTestResult.Insert(true);
        end;

        foreach ThisError in ErrorList do begin
            GLCTestResult.Init();
            GLCTestResult.TransferFields(GLCTestStep, true);
            GLCTestResult.Id := NextResultNo;
            NextResultNo += 1;
            GLCTestResult."Result Type" := GLCTestResult."Result Type"::Failure;
            GLCTestResult."Result Text" := CopyStr(ThisError, 1, MaxStrLen(GLCTestResult."Result Text"));
            GLCTestResult.Insert(true);
        end;

        GLCTestStep."Last Run Success" := ErrorList.Count = 0;
        GLCTestStep.Modify(true);

        GLCResultHandler.ClearData();
    end;



    trigger OnAfterTestRun(CodeunitId: Integer; CodeunitName: Text; FunctionName: Text; Permissions: TestPermissions; Success: Boolean)
    begin
        // Just having this event squelches MESSAGES on codeunit runs.  no code required
        // Fun GOTCHA though!  If the Codeunit is called in can other way than a "Codeunit.Run" with return catching
        // this trigger will not fire, which is why some of the odd global setting filter functions
    end;

}
