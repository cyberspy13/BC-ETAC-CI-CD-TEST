pageextension 50200 ETACCustomerCardPage extends "Customer Card"
{
    trigger OnOpenPage()
    begin
        Grec_ETACSelectedCustomersTable.SetRange("User ID", UserId());
        if Grec_ETACSelectedCustomersTable.FindSet() then begin
            repeat
                if Grec_ETACSelectedCustomersTable."Select All" then begin
                    Gcdu_ETACPermissionCodeUnit.ETACAllCustomsBlock(UserId(), Rec);
                    if Grec_ETACSelectedCustomersTable."Edit Record" then
                        CurrPage.Editable(false);
                end;
            until Grec_ETACSelectedCustomersTable.Next() = 0;
        end else
            Grec_ETACSelectedCustomersTable.Reset();
        Grec_ETACSelectedCustomersTable.SetRange("User ID", UserId());
        Grec_ETACSelectedCustomersTable.SetRange("Source No.", Rec."No.");
        Grec_ETACSelectedCustomersTable.SetRange("Source Table", Grec_ETACSelectedCustomersTable."Source Table"::customer);

        if Grec_ETACSelectedCustomersTable.FindFirst() then
            if Grec_ETACSelectedCustomersTable."View Record" then
                Error('Current user cannot open the Customer Card page. Please review Control Management Page');

        if Grec_ETACSelectedCustomersTable."Edit Record" then
            CurrPage.Editable(false);
    end;

    var
        Grec_ETACSelectedCustomersTable: Record ETAC_CustVendControlMngmTable;
        Gcdu_ETACPermissionCodeUnit: Codeunit ETACPermissionCodeUnit;
}
