$key_root = "HKLM:\Software\Policies\Google\Chrome"
New-Item $key_root -Force | Out-Null

<#
      POLICY !!BrowserSignin_Policy
        #if version >= 4
          SUPPORTED !!SUPPORTED_WIN7
        #endif
        EXPLAIN !!BrowserSignin_Explain

        PART !!BrowserSignin_Part  DROPDOWNLIST
          VALUENAME "BrowserSignin"
          ITEMLIST
            NAME !!BrowserSignin_Disable_DropDown VALUE NUMERIC 0
            NAME !!BrowserSignin_Enable_DropDown VALUE NUMERIC 1
            NAME !!BrowserSignin_Force_DropDown VALUE NUMERIC 2
          END ITEMLIST
        END PART
      END POLICY
#>
$name = "BrowserSignin"
$value = 0 # Disable Chrome/Google sign-in to browser
$type = "DWord"
Set-ItemProperty $key_root -name $name -value $value -Type $type -force | Out-Null

<# from chrome.adm
      CATEGORY !!PasswordManager_Category
        POLICY !!PasswordManagerEnabled_Policy
          #if version >= 4
            SUPPORTED !!SUPPORTED_WIN7
          #endif
          EXPLAIN !!PasswordManagerEnabled_Explain
          VALUENAME "PasswordManagerEnabled"
          VALUEON NUMERIC 1
          VALUEOFF NUMERIC 0
        END POLICY

        POLICY !!PasswordLeakDetectionEnabled_Policy
          #if version >= 4
            SUPPORTED !!SUPPORTED_WIN7
          #endif
          EXPLAIN !!PasswordLeakDetectionEnabled_Explain
          VALUENAME "PasswordLeakDetectionEnabled"
          VALUEON NUMERIC 1
          VALUEOFF NUMERIC 0
        END POLICY

      END CATEGORY
#>
$name = "PasswordManagerEnabled"
$value = 0 # Disable browser password manager
$type = "DWord"
Set-ItemProperty $key_root -name $name -value $value -Type $type -force | Out-Null
$name = "PasswordLeakDetectionEnabled"
$value = 0 # Disable browser password manager
$type = "DWord"
Set-ItemProperty $key_root -name $name -value $value -Type $type -force | Out-Null
