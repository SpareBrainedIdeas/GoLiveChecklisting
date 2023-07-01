codeunit 76002 "GLC Utilities"
{

    procedure UpsertCategory(NewCategoryDescription: Text[100]; Order: Integer): Integer
    var
        GLCCategory: Record "GLC Category";
    begin
        GLCCategory.SetRange(Description, NewCategoryDescription);
        GLCCategory.ReadIsolation(IsolationLevel::ReadCommitted);
        GLCCategory.SetLoadFields(Id, Description);
        if GLCCategory.FindFirst() then
            exit(GLCCategory.Id);

        GLCCategory.Init();
        GLCCategory.Validate(Id, Order);
        GLCCategory.Validate(Description, NewCategoryDescription);
        GLCCategory.Insert(true);
        exit(GLCCategory.Id);
    end;

    procedure UpsertSubcategory(CategoryId: Integer; NewSubcategoryDescription: Text[100]): Integer
    var
        GLCSubcategory: Record "GLC Subcategory";
    begin
        GLCSubcategory.SetRange("Category Id", CategoryId);
        GLCSubcategory.SetRange(Description, NewSubcategoryDescription);
        GLCSubcategory.ReadIsolation(IsolationLevel::ReadCommitted);
        GLCSubcategory.SetLoadFields(Id, Description);
        if GLCSubcategory.FindFirst() then
            exit(GLCSubcategory.Id);

        GLCSubcategory.Init();
        GLCSubcategory.Validate("Category Id", CategoryId);
        GLCSubcategory.Validate(Description, NewSubcategoryDescription);
        GLCSubcategory.Insert(true);
        exit(GLCSubcategory.Id);
    end;

    procedure UpsertTestStep(CategoryId: Integer; SubcategoryId: Integer; NewTestStepDescription: Text[100]; WhichCodeunitId: Integer): Integer
    var
        GLCTestStep: Record "GLC Test Step";
    begin
        GLCTestStep.SetRange("Category Id", CategoryId);
        GLCTestStep.SetRange("Subcategory Id", SubcategoryId);
        GLCTestStep.SetRange(Description, NewTestStepDescription);
        GLCTestStep.ReadIsolation(IsolationLevel::ReadCommitted);
        GLCTestStep.SetLoadFields(Id, Description, "Test Codeunit Id");
        if GLCTestStep.FindFirst() then
            exit(GLCTestStep.Id);

        GLCTestStep.Init();
        GLCTestStep.Validate("Category Id", CategoryId);
        GLCTestStep.Validate("Subcategory Id", SubcategoryId);
        GLCTestStep.Validate(Description, NewTestStepDescription);
        GLCTestStep.Validate("Test Codeunit Id", WhichCodeunitId);
        GLCTestStep.Insert(true);
        exit(GLCTestStep.Id);
    end;

    procedure GetStyleText(SuccessCount: Integer; FailureCount: Integer): Text
    begin
        if (SuccessCount = 0) and (FailureCount = 0) then
            exit('Standard');

        if FailureCount = 0 then
            exit('Favorable');

        if SuccessCount = 0 then
            exit('Unfavorable');

        exit('Ambiguous');

    end;
}
