{ config, lib, pkgs, ... }:

{
  # Setup mail indexing with mbsync / mu
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.mu.enable = true;
  accounts.email = {
    # Main account used for fetching all and sending personal mail
    accounts.mailbox = {
      address = "linus@sehn.tech";
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };
      imap = {
        host = "imap.mailbox.org";
        port = 993;
      };
      msmtp.enable = true;
      smtp = {
        host = "smtp.mailbox.org";
        port = 465;
      };
      primary = true;
      userName = "linus@sehn.tech";
      passwordCommand = "gpg --decrypt ~/.mailpass-mailbox.gpg 2>/dev/null";
    };
    # Account for sending mails via FSFE mailserver
    accounts.fsfe = {
      address = "linus@fsfe.org";
      msmtp.enable = true;
      smtp = {
        host = "mail.fsfe.org";
        port = 587;
        tls.useStartTls = true;
      };
      userName = "linus@fsfe.org";
      passwordCommand = "gpg --decrypt ~/.mailpass-fsfe.gpg 2>/dev/null";
    };
  };
}
