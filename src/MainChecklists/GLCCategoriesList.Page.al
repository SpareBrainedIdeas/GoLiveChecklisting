page 76002 "GLC Categories List"
{
    ApplicationArea = All;
    Caption = 'Go-Live Checklist Categories';
    PageType = List;
    SourceTable = "GLC Category";
    UsageCategory = Tasks;
    Editable = false;
    CardPageId = "GLC Category Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Id; Rec."Id")
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
            action(RunAllTests)
            {
                ApplicationArea = All;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'Run All Tests';
                ToolTip = 'This will run all tests across all categories.';
                RunObject = codeunit "GLC Check Runner";

                trigger OnAction()
                begin

                end;
            }
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
                    CurrPage.GetRecord(GLCCategories);
                    GLCCheckRunner.SetCategoryFilter(GLCCategories);
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
