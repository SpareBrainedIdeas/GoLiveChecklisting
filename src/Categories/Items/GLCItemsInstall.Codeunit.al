codeunit 76050 "GLC Items Install"
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
        CategoryId := GLCUtilities.UpsertCategory('Item Tests', 4);

        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Items Counts (Blocked/Unblocked)');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Validate Block Counts', Codeunit::"GLC Item Block");

        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Item Posting Setups');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Item Jnl - Positive Adjustments');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Item Positive Adjustment");
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Purchase Receipt');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Sales Shipment');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Transfer');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Sample', Codeunit::"GLC Demo Result");
    end;
}
