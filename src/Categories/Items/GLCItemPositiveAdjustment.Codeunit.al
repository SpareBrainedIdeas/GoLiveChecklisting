codeunit 76052 "GLC Item Positive Adjustment"
{
    Subtype = Test;

    //This Codeunit will iterate through each location/item, creating an Item Journal to adjust in 100 of the item

    trigger OnRun()
    var
        Location: Record Location;
        Item: Record Item;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalPostLine: Codeunit "Item Jnl.-Post Line";
        LibraryInventory: Codeunit "Library - Inventory";
        GLCResultHandler: Codeunit "GLC Result Handler";
    begin
        Item.SetRange(Blocked, false);
        Location.SetRange("Directed Put-away and Pick", false);
        Location.SetRange("Use As In-Transit", false);

        if Location.FindSet() then
            repeat
                if Item.FindSet() then
                    repeat
                        if CreateJournalLine(ItemJournalLine, Item."No.", Location.Code) then begin
                            ItemJournalPostLine.RunWithCheck(ItemJournalLine);
                        end else
                            GLCResultHandler.CacheError(StrSubstNo('Could not create an Item Journal Line for Item %1 in Location %2: %3', Item."No.", Location.Code, GetLastErrorText()));
                    until Item.Next() < 1;
                GLCResultHandler.CacheResult(StrSubstNo('Successfully adjusted %1 Items into Location %2', Item.Count, Location.Code));
            until Location.Next() < 1;
    end;

    procedure CreateJournalLine(var ItemJournalLine: Record "Item Journal Line"; ItemNo: Code[20]; LocationCode: Code[10]): Boolean
    var
        LibraryInventory: Codeunit "Library - Inventory";
    begin
        LibraryInventory.CreateItemJnlLine(ItemJournalLine, Enum::"Item Journal Entry Type"::"Positive Adjmt.", WorkDate(), ItemNo, 100, LocationCode);
        exit(true);
    end;
}
