param([string]$pathinput)

# Load required assemblies
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

function Set-FolderIcon
{
	[CmdletBinding()]
	param
	(	
		[Parameter(Mandatory=$True,
		Position=0)]
		[string[]]$Icon,
		[Parameter(Mandatory=$True,
		Position=1)]
		[string]$Path,
		[Parameter(Mandatory=$False)]
		[switch]
		$Recurse	
	)
	BEGIN
	{
		$originallocale = $PWD
		$iconfiles = Get-ChildItem $Path -Recurse -Force | Where-Object {$_.Name -like "FOLDER.ICO"}
		$iconfiles = $iconfiles.FullName
		$inifiles = Get-ChildItem $Path -Recurse -Force | where-Object {$_.Name -like "DESKTOP.INI"}
		$inifiles = $inifiles.FullName
		#Creating content of the DESKTOP.INI file.
		$ini = '[.ShellClassInfo]
				IconFile=folder.ico
				IconIndex=0
				ConfirmFileOp=0'
		Set-Location $Path
		Set-Location ..	
		Get-ChildItem | Where-Object {$_.FullName -eq "$Path"} | ForEach {$_.Attributes = 'Directory, System'}
	}	
	PROCESS
	{
		Remove-Item $iconfiles -Force
		Remove-Item $inifiles -Force
		$ini | Out-File $Path\DESKTOP.INI -Force
        Copy-Item -Path $Icon -Destination $Path\FOLDER.ICO	-Force
        ie4uinit.exe -show
	}	
	END
	{
		$inifile = Get-Item $Path\DESKTOP.INI -Force
		$inifile.Attributes = 'Hidden'
		$icofile = Get-Item $Path\FOLDER.ICO -Force
		$icofile.Attributes = 'Hidden'
		Set-Location $originallocale		
	}
}

function Remove-SetIcon
{
	[CmdletBinding()]
	param
	(	
		[Parameter(Mandatory=$True,
		Position=0)]
		[string]$Path
	)
	BEGIN
	{
		$originallocale = $PWD
		$iconfiles = Get-ChildItem $Path -Recurse -Force | Where-Object {$_.Name -like "FOLDER.ICO"}
		$iconfiles = $iconfiles.FullName
		$inifiles = Get-ChildItem $Path -Recurse -Force | where-Object {$_.Name -like "DESKTOP.INI"}
		$inifiles = $inifiles.FullName
	}
	PROCESS
	{
		Remove-Item $iconfiles -Force
		Remove-Item $inifiles -Force
		Set-Location $Path
		Set-Location ..
		Get-ChildItem | Where-Object {$_.FullName -eq "$Path"} | ForEach {$_.Attributes = 'Directory'}	
	}
	END
	{
		Set-Location $originallocale
	}
}

#.ico file locations
$Green_ico = "${env:ProgramFiles}" + "\FolderColor\Green.ico"
$Red_ico = "${env:ProgramFiles}" + "\FolderColor\Red.ico"
$Cyan_ico = "${env:ProgramFiles}" + "\FolderColor\Cyan.ico"
$Blue_ico = "${env:ProgramFiles}" + "\FolderColor\Blue.ico"
$Purple_ico = "${env:ProgramFiles}" + "\FolderColor\Purple.ico"

#default window size
$menuitem_pos = 0
$leftindent = 3
$buttonsizex = 200
$buttonsizey = 32

#make a text box
$textbox_Display = New-Object System.Windows.Forms.TextBox
    $textbox_Display.Location = New-Object System.Drawing.Size(($leftindent),($menuitem_pos+4))
    $textbox_Display.Size = New-Object System.Drawing.Size(($buttonsizex-2),25)
    $textbox_Display.ScrollBars = "None"
    $textbox_Display.Multiline = "False"
    $textbox_Display.Font = "Courier"
    $textbox_Display.Anchor = [System.Windows.Forms.AnchorStyles]::Top
    $textbox_Display.Text = $pathinput
#make room for the next
$menuitem_pos = $menuitem_pos + $buttonsizey


# - - - - - - - - - - - New Button - - - - - - - - - - -
#make a button
$button_Green = New-Object System.Windows.Forms.Button
    $button_Green.Location = New-Object System.Drawing.Size($leftindent,($menuitem_pos+5))
    $button_Green.Size = New-Object System.Drawing.Size($buttonsizex,$buttonsizey)
    $button_Green.TextAlign = "MiddleCenter"
    $button_Green.Text = "Green"
    $button_Green.BackColor = "LightGreen"
#what does the button do
$button_Green.Add_Click({
    Set-FolderIcon -Path $textbox_Display.Text -Icon $Green_ico
    [void] $Form_Window.Close()
})
#make room for the next
$menuitem_pos = $menuitem_pos + $buttonsizey
#dont forget to add the button to the menu at bottom of script
# - - - - - - - - - - - End of Button - - - - - - - - - -

# - - - - - - - - - - - New Button - - - - - - - - - - -
#make a button
$button_Red = New-Object System.Windows.Forms.Button
    $button_Red.Location = New-Object System.Drawing.Size($leftindent,($menuitem_pos+5))
    $button_Red.Size = New-Object System.Drawing.Size($buttonsizex,$buttonsizey)
    $button_Red.TextAlign = "MiddleCenter"
    $button_Red.Text = "Red"
    $button_Red.BackColor = "Salmon"
#what does the button do
$button_Red.Add_Click({
    Set-FolderIcon -Path $textbox_Display.Text -Icon $Red_ico
    [void] $Form_Window.Close()
})
#make room for the next
$menuitem_pos = $menuitem_pos + $buttonsizey
#dont forget to add the button to the menu at bottom of script
# - - - - - - - - - - - End of Button - - - - - - - - - -

# - - - - - - - - - - - New Button - - - - - - - - - - -
#make a button
$button_Blue = New-Object System.Windows.Forms.Button
    $button_Blue.Location = New-Object System.Drawing.Size($leftindent,($menuitem_pos+5))
    $button_Blue.Size = New-Object System.Drawing.Size($buttonsizex,$buttonsizey)
    $button_Blue.TextAlign = "MiddleCenter"
    $button_Blue.Text = "Blue"
    $button_Blue.BackColor = "CornflowerBlue"
#what does the button do
$button_Blue.Add_Click({
    Set-FolderIcon -Path $textbox_Display.Text -Icon $Blue_ico
    [void] $Form_Window.Close()
})
#make room for the next
$menuitem_pos = $menuitem_pos + $buttonsizey
#dont forget to add the button to the menu at bottom of script
# - - - - - - - - - - - End of Button - - - - - - - - - -

# - - - - - - - - - - - New Button - - - - - - - - - - -
#make a button
$button_Cyan = New-Object System.Windows.Forms.Button
    $button_Cyan.Location = New-Object System.Drawing.Size($leftindent,($menuitem_pos+5))
    $button_Cyan.Size = New-Object System.Drawing.Size($buttonsizex,$buttonsizey)
    $button_Cyan.TextAlign = "MiddleCenter"
    $button_Cyan.Text = "Cyan"
    $button_Cyan.BackColor = "Cyan"
#what does the button do
$button_Cyan.Add_Click({
    Set-FolderIcon -Path $textbox_Display.Text -Icon $Cyan_ico
    [void] $Form_Window.Close()
})
#make room for the next
$menuitem_pos = $menuitem_pos + $buttonsizey
#dont forget to add the button to the menu at bottom of script
# - - - - - - - - - - - End of Button - - - - - - - - - -

# - - - - - - - - - - - New Button - - - - - - - - - - -
#make a button
$button_Purple = New-Object System.Windows.Forms.Button
    $button_Purple.Location = New-Object System.Drawing.Size($leftindent,($menuitem_pos+5))
    $button_Purple.Size = New-Object System.Drawing.Size($buttonsizex,$buttonsizey)
    $button_Purple.TextAlign = "MiddleCenter"
    $button_Purple.Text = "Purple"
    $button_Purple.BackColor = "MediumPurple"
#what does the button do
$button_Purple.Add_Click({
    Set-FolderIcon -Path $textbox_Display.Text -Icon $Purple_ico
    [void] $Form_Window.Close()
})
#make room for the next
$menuitem_pos = $menuitem_pos + $buttonsizey
#dont forget to add the button to the menu at bottom of script
# - - - - - - - - - - - End of Button - - - - - - - - - -

# - - - - - - - - - - - New Button - - - - - - - - - - -
#make a button
$button_Remove = New-Object System.Windows.Forms.Button
    $button_Remove.Location = New-Object System.Drawing.Size($leftindent,($menuitem_pos+5))
    $button_Remove.Size = New-Object System.Drawing.Size($buttonsizex,$buttonsizey)
    $button_Remove.TextAlign = "MiddleCenter"
    $button_Remove.Text = "Default Color"
    $button_Remove.BackColor = "PaleGoldenrod"
#what does the button do
$button_Remove.Add_Click({
    Remove-SetIcon -Path $textbox_Display.Text
    [void] $Form_Window.Close()
})
#make room for the next
$menuitem_pos = $menuitem_pos + $buttonsizey
#dont forget to add the button to the menu at bottom of script
# - - - - - - - - - - - End of Button - - - - - - - - - -

# - - - - - - - - - - - New Button - - - - - - - - - - -
#make a button
$button_Cancel = New-Object System.Windows.Forms.Button
    $button_Cancel.Location = New-Object System.Drawing.Size($leftindent,($menuitem_pos+5))
    $button_Cancel.Size = New-Object System.Drawing.Size($buttonsizex,$buttonsizey)
    $button_Cancel.TextAlign = "MiddleCenter"
    $button_Cancel.Text = "Cancel"
#what does the button do
$button_Cancel.Add_Click({
    [void] $Form_Window.Close()
})
#make room for the next
$menuitem_pos = $menuitem_pos + $buttonsizey
#dont forget to add the button to the menu at bottom of script
# - - - - - - - - - - - End of Button - - - - - - - - - -

# Drawing the window and its controls
$Form_Colorizer = @{
    Text = "Color"
    Size = New-Object System.Drawing.Size(($buttonsizex+20),($menuitem_pos+$buttonsizey+15))
    FormBorderStyle = "FixedDialog"
    TopMost = $false
    MaximizeBox = $false
    MinimizeBox = $false
    ControlBox = $true
    StartPosition = "CenterScreen"
    Font = "Segoe UI"
}

# show Window and populate buttons
$Form_Window = New-Object System.Windows.Forms.Form -Property $Form_Colorizer
$Form_Window.Controls.Add($textbox_Display)
$Form_Window.Controls.Add($button_Green)
$Form_Window.Controls.Add($button_Red)
$Form_Window.Controls.Add($button_Blue)
$Form_Window.Controls.Add($button_Cyan)
$Form_Window.Controls.Add($button_Purple)
$Form_Window.Controls.Add($button_Remove)
$Form_Window.Controls.Add($button_Cancel)
$Form_Window.Add_Shown({$Form_Window.Activate()})
[void] $Form_Window.ShowDialog()