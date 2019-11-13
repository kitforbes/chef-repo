return unless platform_family?('windows')

registry_key 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' do
  values [
    {
      # Show file extensions.
      name: 'HideFileExt',
      type: :dword,
      data: 0,
    },
    {
      # Show hidden files and folders.
      name: 'Hidden',
      type: :dword,
      data: 1,
    },
    {
      # Show super hidden items.
      name: 'ShowSuperHidden',
      type: :dword,
      data: 0,
    },
    {
      # Show server administrator UI.
      name: 'ServerAdminUI',
      type: :dword,
      data: 0,
    },
    {
      # Colour compressed files.
      name: 'ShowEncryptCompressedColor',
      type: :dword,
      data: 1,
    },
    {
      # Disable desktop "peek".
      name: 'DisablePreviewDesktop',
      type: :dword,
      data: 1,
    },
  ]
  action :create
end
