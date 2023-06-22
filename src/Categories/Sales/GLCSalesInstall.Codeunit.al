codeunit 76020 "GLC Sales Install"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GLC Installation", 'OnInstallGLCChecklistPerCompany', '', false, false)]
    local procedure RegisterToChecklist()
    begin
        RegisterModule()
    end;

    local procedure RegisterModule()
    var
        GLCUtilities: Codeunit "GLC Utilities";
        CategoryId: Integer;
        SubcategoryId: Integer;
    begin
        CategoryId := GLCUtilities.UpsertCategory('Customer Tests', 2);

        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Customer Counts (Blocked/Unblocked)');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Validate Clock Counts', Codeunit::"GLC Customer Block");

        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Customer Posting Setups');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Customers - G/L Invoicing');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Customers - Item Orders');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Customers - Shipping');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Customers - Payment Receipt');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Customers - Credits');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
    end;
}
