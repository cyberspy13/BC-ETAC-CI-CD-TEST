pageextension 50203 ETACChartOfAccExt extends "G/L Account Card"
{
    trigger OnOpenPage()
    begin
        Grec_ETACControlMngm.SetRange("User ID", UserId);
        if Grec_ETACControlMngm.FindFirst() then begin
            repeat
                if Grec_ETACControlMngm."Select All" then begin
                    Gcdu_ETACPermissionCodeUnit.ETACAllGlBlock(UserId);
                    if Grec_ETACControlMngm."Edit Record" then
                        CurrPage.Editable(false);
                end;
            until Grec_ETACControlMngm.Next() = 0;
        end else
            Grec_ETACControlMngm.SetRange("User ID", UserId);
        Grec_ETACControlMngm.SetRange("Source No.", Rec."No.");
        Grec_ETACControlMngm.SetRange("Source Table", Grec_ETACControlMngm."Source Table"::"G/L Account");
        if Grec_ETACControlMngm.FindFirst() then
            if Grec_ETACControlMngm."View Record" = true then
                Error('Current user does not have access to open Chart Of Accont %1.', Rec."No.");
        if Grec_ETACControlMngm."Edit Record" = true then
            CurrPage.Editable(false);
    end;

    var
        Grec_ETACControlMngm: Record ETAC_CustVendControlMngmTable;
        Gcdu_ETACPermissionCodeUnit: Codeunit ETACPermissionCodeUnit;
}
