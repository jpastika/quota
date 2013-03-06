class DocumentMailer < ActionMailer::Base
  default :from => "jpastika@spokesystems.com"

  def email(document)
    @document = document
    # mail(:subject => 'Your Quote', :to => "jpastika@spokesystems.com") do |format|
    #       format.text
    #       format.pdf do
    #         attachments["#{document.name}.pdf"] = WickedPdf.new.pdf_from_string(render_to_string(:layout => 'pdf.html', :pdf => @document.name))
    #       end
    #     end
    #     
    mail(:subject => 'Your Quote', :to => "jpastika@spokesystems.com")
    attachments["#{document.name}.pdf"] = WickedPdf.new.pdf_from_string(render_to_string(:layout => 'pdf.html', :pdf => @document.name))
  end
end