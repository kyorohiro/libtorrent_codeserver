#include <cstdlib>
#include "libtorrent/entry.hpp"
#include "libtorrent/bencode.hpp"
#include "libtorrent/session.hpp"
#include "libtorrent/torrent_info.hpp"

#include <iostream>

int main(int argc, char* argv[]) try
{
  if (argc != 2) {
    std::cerr << "usage: ./simple_client torrent-file\n"
      "to stop the client, press return.\n";
    return 1;
  }

  std::cout << "S1" << "\n";
  lt::session s;
  lt::add_torrent_params p;
  p.save_path = ".";
  p.ti = std::make_shared<lt::torrent_info>(argv[1]);
  std::cout << "S2" << "\n";
  s.add_torrent(p);
  std::cout << "S3" << "\n";
  // wait for the user to end
  char a;
  int ret = std::scanf("%c\n", &a);
  (void)ret; // ignore
  std::cout << "S4" << "\n";
  return 0;
}
catch (std::exception const& e) {
  std::cerr << "ERROR: " << e.what() << "\n";
}
