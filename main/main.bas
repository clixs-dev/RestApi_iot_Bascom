'  _____     _    __  __       _                 
' |_   _|_ _| | _|  \/  | ___ (_)       ___ ___  
'   | |/ _` | |/ / |\/| |/ _ \| |      / __/ _ \ 
'   | | (_| |   <| |  | | (_) | |  _  | (_| (_) |
'   |_|\__,_|_|\_\_|  |_|\___// | (_)  \___\___/ 
'                           |__/                 
'By : Dr.AliNazarZadeh 
'===========================================================

$regfile = "m2560def.dat"
$crystal = 8000000

Config Serialout = Buffered , Baud = 9600

Config Portb.0 = Output
Config Portb.1 = Output
Config Portb.2 = Output
Config Portb.3 = Output
Config Portb.4 = Output
Config Portb.5 = Output
Config Portd.0 = Output
Config Portd.1 = Output

Dim LedStatus(8) As Bit
For i = 1 To 8
LedStatus(i) = 0
Next i

Function ReadTemperature() As Byte
ReadTemperature = 25 
End Function

Function ReadGas() As Byte
ReadGas = 0 
End Function

' ======== Json Creator ========
Sub SendLedJSON(conn As Byte)
Dim json As String * 64
json = "{""leds"":["
For i = 1 To 8
json = json & LedStatus(i)
If i < 8 Then json = json & ","
Next i
json = json & "]}"

Print #1, "AT+CIPSEND="; conn; ","; Len(json)
Wait 50
Print #1, json
End Sub

' ======== Json Creator Gas & Tempercher ========
Sub SendSensorJSON(conn As Byte)
Dim json As String * 64
Dim Temperature As Byte
Dim Gas As Byte

Temperature = ReadTemperature()
Gas = ReadGas()

json = "{""temperature"":" & Temperature & ",""gas"":" & Gas & "}"

Print #1, "AT+CIPSEND="; conn; ","; Len(json)
Wait 50
Print #1, json
End Sub

' ======== method Baraye Ersal AT ========
Sub AT(cmd As String)
Print #1, cmd
Wait 200
End Sub

' ======== Init ESP ========
AT "AT+RST"
Wait 2000
AT "AT+CWMODE=2" ' SoftAP
AT "AT+CWSAP=""TakMoj-IoT"",""12345678"",5,3"
Wait 2000
AT "AT+CIPMUX=1"
AT "AT+CIPSERVER=1,80"

' ======== Main ========
Dim cmd As String * 128
Dim conn As Byte

Do
If IsCharWaiting() Then
Input cmd
cmd = LTrim(cmd)
cmd = RTrim(cmd)

If Left(cmd,3) = "+IPD" Then
conn = Val(Mid(cmd,4,1)) ' Number Of Connection

' APi Get For LED ON / OFF
If InStr(cmd,"GET /leds") > 0 Then
SendLedJSON(conn)
End If

Dim i As Byte
For i = 1 To 8
If InStr(cmd,"ON" & i) > 0 Then
Select Case i
Case 1: Set Portb.0
Case 2: Set Portb.1
Case 3: Set Portb.2
Case 4: Set Portb.3
Case 5: Set Portb.4
Case 6: Set Portb.5
Case 7: Set Portd.0
Case 8: Set Portd.1
End Select
LedStatus(i) = 1
End If
If InStr(cmd,"OFF" & i) > 0 Then
Select Case i
Case 1: Reset Portb.0
Case 2: Reset Portb.1
Case 3: Reset Portb.2
Case 4: Reset Portb.3
Case 5: Reset Portb.4
Case 6: Reset Portb.5
Case 7: Reset Portd.0
Case 8: Reset Portd.1
End Select
LedStatus(i) = 0
End If
Next i

' Api Get Sensor & Status  
If InStr(cmd,"GET /sensors") > 0 Or InStr(cmd,"GET /status") > 0 Then
SendSensorJSON(conn)
End If
End If
End If
Loop