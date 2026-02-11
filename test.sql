-- The SQL test script for monitoring disconnected and connected devices project


if object_id('device_connectivity_info') is not null
begin
	truncate table device_connectivity_info
end

insert into device_connectivity_info (dateTime, deviceName, deviceID, action)
values
	(sysdatetime(), N'HID Keyboard Device', N'HID\VID_1A81&PID_1004&MI_00\\8&3710D07D&0&0000', N'disconnected'),
	(sysdatetime(), N'HID-compliant mouse', N'HID\VID_1A81&PID_1004&MI_01&COL01\\8&EA622B4&0&0000', N'disconnected'),
	(sysdatetime(), N'HID-compliant consumer control device', N'HID\VID_1A81&PID_1004&MI_01&COL03\\8&EA622B4&0&0002', N'disconnected'),
	(sysdatetime(), N'HID-compliant vendor-defined device', N'HID\VID_1A81&PID_1004&MI_01&COL02\\8&EA622B4&0&0001', N'disconnected'),
	(sysdatetime(), N'HID-compliant system controller', N'HID\VID_1A81&PID_1004&MI_01&COL04\\8&EA622B4&0&0003', N'disconnected'),
	(sysdatetime(), N'HID-compliant vendor-defined device', N'HID\VID_1A81&PID_1004&MI_01&COL06\\8&EA622B4&0&0005', N'disconnected'),
	(sysdatetime(), N'HID-compliant vendor-defined device', N'HID\VID_1A81&PID_1004&MI_01&COL05\\8&EA622B4&0&0004', N'disconnected'),
	(sysdatetime(), N'USB Composite Device', N'USB\VID_1A81&PID_1004\\6&35367591&0&1', N'disconnected'),
	(sysdatetime(), N'USB Input Device', N'USB\VID_1A81&PID_1004&MI_00\7&52A4C26&0&0000', N'disconnected'),
	(sysdatetime(), N'USB Input Device', N'USB\VID_1A81&PID_1004&MI_01\7&52A4C26&0&0001', N'disconnected'),
	(sysdatetime(), N'HID Keyboard Device', N'HID\VID_1A81&PID_1004&MI_00\\8&3710D07D&0&0000', N'connected'),
	(sysdatetime(), N'HID-compliant mouse', N'HID\VID_1A81&PID_1004&MI_01&COL01\\8&EA622B4&0&0000', N'connected'),
	(sysdatetime(), N'HID-compliant vendor-defined device', N'HID\VID_1A81&PID_1004&MI_01&COL02\\8&EA622B4&0&0001', N'connected'),
	(sysdatetime(), N'HID-compliant consumer control device', N'HID\VID_1A81&PID_1004&MI_01&COL03\\8&EA622B4&0&0002', N'connected'),
	(sysdatetime(), N'HID-compliant vendor-defined device', N'HID\VID_1A81&PID_1004&MI_01&COL06\\8&EA622B4&0&0005', N'connected'),
	(sysdatetime(), N'HID-compliant system controller', N'HID\VID_1A81&PID_1004&MI_01&COL04\\8&EA622B4&0&0003', N'connected'),
	(sysdatetime(), N'HID-compliant vendor-defined device', N'HID\VID_1A81&PID_1004&MI_01&COL05\\8&EA622B4&0&0004', N'connected'),
	(sysdatetime(), N'USB Input Device', N'USB\VID_1A81&PID_1004&MI_00\\7&52A4C26&0&0000', N'connected'),
	(sysdatetime(), N'USB Input Device', N'USB\VID_1A81&PID_1004&MI_01\\7&52A4C26&0&0001', N'connected'),
	(sysdatetime(), N'USB Composite Device', N'USB\VID_1A81&PID_1004\\6&35367591&0&1', N'connected');

select * from device_connectivity_info
