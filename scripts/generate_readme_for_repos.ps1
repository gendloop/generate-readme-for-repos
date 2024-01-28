param(
    [string]$file_in = "repos.json",
    [string]$file_out = "README.md",
    [string]$label = "Repos",
    [string]$repo_name = "",
    [string]$owner = "gendloop"
)

New-Item -ItemType File -Path $file_out -Force

echo "# ${repo_name}" >> $file_out
echo "" >> $file_out

$json = Get-Content -Raw $file_in
$json_obj = $json | jq -c
$data = $json_obj | ConvertFrom-Json

echo "| **Num** | **Repo** | **Description** |" >> $file_out
echo "| ---- | ---- | ---- |" >> $file_out

$count = 0;
foreach ($item in $data) {
    $count++;
    $name = $item.name
    $description = $item.description
    Write-Host "${name}: ${description}"
    $line_content = "| $count " + "| [![${name}](https://img.shields.io/v/release/${owner}/${name}?display_name=release&style=plastic&logo=github&label=${name}&labelColor=%23bf2b1f&color=blue)](https://github.com/${owner}/${name})" + "| ${description} |"

    echo $line_content >> $file_out
    # echo "" >> $file_out
}
