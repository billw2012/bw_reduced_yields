$file = "../extracted/libraries/regionyields.xml"
$doc = [xml](Get-Content $file)

$diff = New-Object System.Xml.XmlDocument
$diff.AppendChild($diff.CreateElement("diff"))

foreach ($resource in $doc.regionyields.resource) {
    foreach ($yield in $resource.yield) {
        $replace = $diff.CreateElement("replace")
        $replace.SetAttribute("sel", "/regionyields/resource[@ware='$($resource.ware)']/yield[@name='$($yield.name)']/@resourcedensity")
        $replace.InnerText = ($yield.resourcedensity * 0.1)
        $diff.DocumentElement.AppendChild($replace) | Out-Null
    }
}

$diff.Save((Resolve-Path "libraries/regionyields.xml"))
