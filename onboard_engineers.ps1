# ==================================================
# SESSION 13: THE AUTOMATED ONBOARDING
# Operator Deployment Script
# ==================================================

Write-Host "[*] Beginning Engineering Onboarding..."

# INSTRUCTION 1: Create a loop (For 1 to 5)
for ($i=1; $i -le 5; $i++) {

    # INSTRUCTION 2: Inside the loop, use New-ADUser to create Eng_User1 through Eng_User5.
    # Ensure you set the -Path to your new Engineering OU, and require a password change.

    $password = ConvertTo-SecureString "Titan123!" -AsPlainText -Force

    New-ADUser `
        -Name "Eng_User$i" `
        -SamAccountName "Eng_User$i" `
        -UserPrincipalName "Eng_User$i@titan.local" `
        -Path "OU=Engineering,DC=titan,DC=local" `
        -AccountPassword $password `
        -Enabled $true `
        -ChangePasswordAtLogon $true
}

Write-Host "[+] All engineers onboarded successfully."
