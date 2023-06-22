codeunit 76001 "GLC Installation"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        OnInstallGLCChecklistPerCompany();
    end;

    [BusinessEvent(false)]
    local procedure OnInstallGLCChecklistPerCompany()
    begin
    end;
}
