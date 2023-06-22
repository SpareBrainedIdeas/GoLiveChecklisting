codeunit 76010 "GLC GL Install"
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
        CategoryId := GLCUtilities.UpsertCategory('General Ledger and Posting Setups', 1);

        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Income/Balance Sheet Settings');
        GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, 'Validate Account Types', Codeunit::"GLC GL Validate Acc. Type");

        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Sales Accounts Posting Settings');
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Purchase Accounts Posting Settings');
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Direct Posting Controlled');
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'Posting Groups and Setup');
        SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, 'VAT Posting Groups and Setup');
    end;
}
