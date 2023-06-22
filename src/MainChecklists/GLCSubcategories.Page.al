page 76004 "GLC Subcategories"
{
    Caption = 'Checklist Subcategories';
    PageType = ListPart;
    SourceTable = "GLC Subcategory";
    AutoSplitKey = false;
    Editable = false;
    DataCaptionFields = Description;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Id; Rec.Id)
                {
                    ToolTip = 'Specifies the value of the Id field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    StyleExpr = LineStyle;
                }

                field("Test Steps"; Rec."Test Steps")
                {
                    ToolTip = 'Specifies the value of the Test Steps field.';
                    ApplicationArea = All;
                }
                field("Last Run Date"; Rec."Last Run Date")
                {
                    ToolTip = 'Specifies the value of the Last Run Date field.';
                    ApplicationArea = All;
                }
                field(Results; Rec.Results)
                {
                    ToolTip = 'Specifies the value of the Results field.';
                    ApplicationArea = All;
                }
                field(Successes; Rec.Successes)
                {
                    ToolTip = 'Specifies the value of the Successes field.';
                    ApplicationArea = All;
                }
                field(Failures; Rec.Failures)
                {
                    ToolTip = 'Specifies the value of the Failures field.';
                    ApplicationArea = All;
                }
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
                Caption = 'Run Selected Tests';
                ToolTip = 'This will run the tests for the selected subcategories.';

                trigger OnAction()
                var
                    GLCSubcategories: Record "GLC Subcategory";
                    GLCCheckRunner: Codeunit "GLC Check Runner";
                begin
                    CurrPage.GetRecord(GLCSubcategories);
                    GLCCheckRunner.SetSubcategoryFilter(GLCSubcategories);
                    GLCCheckRunner.Run();
                end;
            }
        }
    }


    var
        LineStyle: Text;

    trigger OnAfterGetRecord()
    var
        GLCUtilities: Codeunit "GLC Utilities";
    begin
        LineStyle := GLCUtilities.GetStyleText(Rec.Successes, Rec.Failures);
    end;
}
