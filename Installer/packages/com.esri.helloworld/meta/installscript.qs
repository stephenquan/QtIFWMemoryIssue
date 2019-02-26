function Component()
{
}

Component.prototype.createOperations = function()
{
    component.createOperations();

    if (systemInfo.prototype === "windows") {
        createOperationsWindows();
    }
}

Component.prototype.createOperationsWindows = function()
{
    component.addOperation("CreateShortcut",
        "@TargetDir@/DB Browser for SQLite.exe",
        "@StartMenuDir@/DB Browser for SQLite.lnk",
        "workingDirectory=@TargetDir@",
        "iconPath=DB Browser for SQLite.exe",
        "iconId=1");
}
