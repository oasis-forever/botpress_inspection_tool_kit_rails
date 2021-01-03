module DownloadHelper
  TIMEOUT = 10
  PATH    = Rails.root.join("tmp/downloads")

  extend self

  def downloads
    Dir[PATH.join("*")]
  end

  def download
    downloads.last
  end

  def download_content
    wait_for_download
    File.read(download)
  end

  def wait_for_download
    Timeout.timeout(TIMEOUT) do
      sleep 0.1 until downloaded?
    end
  end

  def downloaded?
    !downloading? && downloads.any?
  end

  def downloading?
    downloads.grep(/\.crdownload$/).any?
  end

  def clear_downloads
    FileUtils.rm_f(downloads)
  end

  def download_file_name
    wait_for_download
    File.basename(download)
  end
end
