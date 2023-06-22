codeunit 76002 "GLC Utilities"
{

    procedure UpsertCategory(NewCategoryDescription: Text[100]; Order: Integer): Integer
    var
        GLCCategory: Record "GLC Category";
    begin
        GLCCategory.SetRange(Description, NewCategoryDescription);
        if GLCCategory.FindFirst() then
            exit(GLCCategory.Id);

        GLCCategory.Init();
        GLCCategory.Id := Order;
        GLCCategory.Description := NewCategoryDescription;
        GLCCategory.Insert(true);
        exit(GLCCategory.Id);
    end;

    procedure UpsertSubcategory(CategoryId: Integer; NewSubcategoryDescription: Text[100]): Integer
    var
        GLCSubcategory: Record "GLC Subcategory";
    begin
        GLCSubcategory.SetRange("Category Id", CategoryId);
        GLCSubcategory.SetRange(Description, NewSubcategoryDescription);
        if GLCSubcategory.FindFirst() then
            exit(GLCSubcategory.Id);

        GLCSubcategory.Init();
        GLCSubcategory."Category Id" := CategoryId;
        GLCSubcategory.Description := NewSubcategoryDescription;
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
        if GLCTestStep.FindFirst() then
            exit(GLCTestStep.Id);

        GLCTestStep.Init();
        GLCTestStep."Category Id" := CategoryId;
        GLCTestStep."Subcategory Id" := SubcategoryId;
        GLCTestStep.Description := NewTestStepDescription;
        GLCTestStep."Test Codeunit Id" := WhichCodeunitId;
        GLCTestStep.Insert(true);
        exit(GLCTestStep.Id);
    end;

    procedure GetStyleText(SuccessCount: Integer; FailureCount: Integer): Text
    begin
        if (SuccessCount = 0) and (FailureCount = 0) then
            exit('Standard');
        if (FailureCount = 0) then
            exit('Favorable');
        if (SuccessCount = 0) then
            exit('Unfavorable');
        exit('Ambiguous');

    end;
}
