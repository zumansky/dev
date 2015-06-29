#install the mailR package
install.packages('mailR')
#load the library
library('mailR')

#================================================================#
# testing the mailR package - sending an email with attached pdf #
#================================================================#

#set the pseudo random number generator seed so we can get the same results
#generate 1000 gaussian/uniform numbers
set.seed(1); gNum <- rnorm(1000)
set.seed(1); uNum <- runif(1000)
#path where the pdf will be stored locally
pdfFileName1 <- '/tmp/histoGauss.pdf'
pdfFileName2 <- '/tmp/histoUnif.pdf'

#plot the first pdf
pdf(file = pdfFileName1)
hist(gNum, main='gaussian distribution')
graphics.off()

#plot the second pdf
pdf(file = pdfFileName2)
hist(uNum, main='uniform distribution')
graphics.off()

#Send the email via a SMTP server that requires authentication:
#changed an option in gmail by removing extra security there:
#https://www.google.com/settings/security/lesssecureapps
send.mail(from = 'sender@gmail.com',
          to = c('recipient@gmail.com'),
          subject = 'Subject of my email',
          body = 'Body of my email',
          smtp = list(host.name = 'smtp.gmail.com', port = 465, 
                      user.name = 'sender@gmail.com', passwd = 'senderpassword', 
                      ssl = TRUE),
          authenticate = TRUE,
          send = TRUE,
          attach.files = c(pdfFileName1, pdfFileName2),
          file.names = c('file1.pdf', 'file2.pdf') # optional parameter
)

#Send the email via a SMTP server that does not require authentication
send.mail(debug = TRUE,
          from = 'sender@gmail.com',
          to = c('recipient@gmail.com'),
          subject = "Subject of the email",
          body = "Body of the email",
          smtp = list(host.name = "aspmx.l.google.com", port = 25, ssl=FALSE),
          authenticate = FALSE,
          send = TRUE,
          attach.files = c(pdfFileName1, pdfFileName2),
          file.names = c('file1.pdf', 'file2.pdf') # optional parameter
)


