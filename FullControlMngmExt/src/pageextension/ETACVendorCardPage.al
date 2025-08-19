pageextension 50201 ETACVendorCardPage extends "Vendor Card"
{
    trigger OnOpenPage()
    begin
        Grec_ETACControlMngm.SetRange("User ID", UserId);
        if Grec_ETACControlMngm.FindFirst() then begin
            repeat
                if Grec_ETACControlMngm."Select All" then begin
                    Gcdu_ETACPermissionCodeUnit.ETACAllVendorsBlock(UserId);
                    if Grec_ETACControlMngm."Edit Record" then
                        CurrPage.Editable(false);
                end;
            until Grec_ETACControlMngm.Next() = 0;
        end else
            Grec_ETACControlMngm.SetRange("User ID", UserId);
        Grec_ETACControlMngm.SetRange("Source No.", Rec."No.");
        Grec_ETACControlMngm.SetRange("Source Table", Grec_ETACControlMngm."Source Table"::vendor);
        if Grec_ETACControlMngm.FindFirst() then
            if Grec_ETACControlMngm."View Record" = true then
                Error('Current user cannot open the Vendor Card page. Please review Control Management Page');
        if Grec_ETACControlMngm."Edit Record" = true then
            CurrPage.Editable(false);
    end;

    var
        Grec_ETACControlMngm: Record ETAC_CustVendControlMngmTable;
        Gcdu_ETACPermissionCodeUnit: Codeunit ETACPermissionCodeUnit;
}
