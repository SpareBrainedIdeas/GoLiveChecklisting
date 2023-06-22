codeunit 76004 "GLC Demo Filler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GLC Installation", 'OnInstallGLCChecklistPerCompany', '', false, false)]
    local procedure RegisterToChecklist()
    var
        Subcategories: List of [Text[100]];
        CategoryId: Integer;
    begin
        // Most of the checks I'm not writing just for a free 15 minute demo,
        // so this codeunit helps make it look more complete to understand the potential value

        // Vendor
        CategoryId := 1000;
        Subcategories.Add('Vendor Counts (Blocked/Unblocked');
        Subcategories.Add('Vendor Posting Groups');
        Subcategories.Add('Vendor Orders - G/L Accounts');
        Subcategories.Add('Vendor Orders - Items');
        Subcategories.Add('Vendor - Receiving');
        Subcategories.Add('Vendor - Invoice Posting');
        Subcategories.Add('Vendor - Payments Made');
        Subcategories.Add('Vendor - Credits');
        RegisterModule(CategoryId, 'Vendor and Purchasing Settings', Subcategories);
        Clear(Subcategories);

        // Inventory
        CategoryId := 1001;
        Subcategories.Add('Location Counts');
        Subcategories.Add('Location Policy Settings');
        Subcategories.Add('Bin Counts');
        Subcategories.Add('Inventory Posting Group Count');
        Subcategories.Add('Inventory Posting Setups');
        RegisterModule(CategoryId, 'Inventory/Location Settings', Subcategories);
        Clear(Subcategories);
    end;

    local procedure RegisterModule(var CategoryId: Integer; CategoryName: Text[100]; SubCategories: List of [Text[100]]);
    var
        GLCUtilities: Codeunit "GLC Utilities";
        SubcategoryId: Integer;
        SubcategoryName: Text[100];
    begin
        CategoryId := GLCUtilities.UpsertCategory(CategoryName, CategoryId);

        foreach SubcategoryName in SubCategories do begin
            SubcategoryId := GLCUtilities.UpsertSubcategory(CategoryId, SubcategoryName);
            GLCUtilities.UpsertTestStep(CategoryId, SubcategoryId, SubcategoryName, Codeunit::"GLC Demo Result");
        end;
    end;
}
