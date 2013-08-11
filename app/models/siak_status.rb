class SiakStatus < ActiveRecord::Base
  def self.status_string
    case status_sym
    when :ok
      "Siak baik-baik saja"
    when :warn
      "Kamu mungkin akan mengalami masalah kecepatan"
    when :fail
      "Ooopppssss.. sepertinya SIAK mengalami masalah"
    end
  end
  def self.status_sym
    if @ping_ms < 5000
      :ok
    elsif @ping_ms < 10000
      :warn
    else
      :fail
    end
  end
end
