page 76003 "GLC Category Card"
{
    Caption = 'GLC Category Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "GLC Category";
    Editable = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Visible = false;

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            part(Subcategories; "GLC Subcategories")
            {
                SubPageLink = "Category Id" = field(Id);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RunCategoryTests)
            {
                ApplicationArea = All;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'Run Selected Tests';
                ToolTip = 'This will run the tests for the selected categories.';

                trigger OnAction()
                var
                    GLCCategories: Record "GLC Category";
                    GLCCheckRunner: Codeunit "GLC Check Runner";
                begin
                    CurrPage.SetSelectionFilter(GLCCategories);
                    GLCCheckRunner.SetCategoryFilter(GLCCategories);
                    GLCCheckRunner.Run();
                end;
            }
        }
    }
}