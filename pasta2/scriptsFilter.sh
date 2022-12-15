#!/usr/bin/python3

from scapy.all import *

pcapFiles=[]
with open("filesNames", 'r') as arquivo:
  for line in arquivo:
    pcapFiles.append(line.rstrip('\n'));


pasta='./pcap/fil/'
linhaPacks = []
for arq in pcapFiles:
  pcap = pasta + arq
  print(pcap)
  dicionario={'packs': 0,'tcp': 0, 'syn': 0, 'syn_ack': 0, 'fin': 0, 'ack': 0, 'rst': 0, 'phs':0}
  
  packeges = sniff(offline=pcap)
  dicionario['packs'] = len(packeges)
  if len(packeges) == 0 :
    break

  myfilter = 'tcp'
  tcp = sniff(offline=pcap, filter=myfilter)
  dicionario['tcp'] = len(tcp)

  myfilter = 'tcp[13] = 2'
  syn = sniff(offline=pcap, filter=myfilter)
  dicionario['syn'] = len(syn)

  myfilter = 'tcp[13] = 18'
  synack = sniff(offline=pcap, filter=myfilter)
  dicionario['syn_ack'] = len(synack)

  myfilter = "tcp[tcpflags] & (tcp-fin) != 0"
  fin = sniff(offline=pcap, filter=myfilter)
  dicionario['fin'] = len(fin)

  myfilter = 'tcp[13] = 16'
  ack = sniff(offline=pcap, filter=myfilter)
  dicionario['ack'] = len(ack)

  myfilter = "tcp[tcpflags] & (tcp-rst) != 0"
  pctrst = sniff(offline=pcap, filter=myfilter)
  dicionario['rst'] = len(pctrst)

  myfilter = "tcp[13] & 8 != 0"
  pctpsh = sniff(offline=pcap, filter=myfilter)
  dicionario['psh'] = len(pctpsh)

  concat=''
  for i in dicionario:
    concat += str(dicionario[i])+","

  linhaPacks.append(concat)

# print(linhaPacks)

print('packges,tcp,syn,syn_ack,fin,ack,rst,phs,class')
for j in linhaPacks:
  print(j)

fileNameInput = input("Digite o nome do arquivo:")
with open(fileNameInput, 'w') as arquivo:
  arquivo.writelines('packges,tcp,syn,syn_ack,fin,ack,rst,phs,class\n')
  for j in linhaPacks:
    arquivo.writelines(j+'\n')


# pasta ='./pcap/'
# pcap = pasta + 'captura2.cap'

# dicionario={'packs': 0,'tcp': 0, 'syn': 0, 'syn_ack': 0, 'fin': 0, 'ack': 0, 'rst': 0, 'phs':0}

# packeges = sniff(offline=pcap)
# # print("PACKS", len(packeges))
# dicionario['packs'] = len(packeges)

# myfilter = 'tcp'
# tcp = sniff(offline=pcap, filter=myfilter)
# # print("TCP", len(tcp))
# dicionario['tcp'] = len(tcp)

# myfilter = 'tcp[13] = 2'
# syn = sniff(offline=pcap, filter=myfilter)
# # print("SYN",len(syn))
# dicionario['syn'] = len(syn)

# myfilter = 'tcp[13] = 18'
# synack = sniff(offline=pcap, filter=myfilter)
# # print("SYN_ACK",len(synack))
# dicionario['syn_ack'] = len(synack)

# myfilter = "tcp[tcpflags] & (tcp-fin) != 0"
# fin = sniff(offline=pcap, filter=myfilter)
# # print("FIN",len(fin))
# dicionario['fin'] = len(fin)

# myfilter = 'tcp[13] = 16'
# ack = sniff(offline=pcap, filter=myfilter)
# # print("ACK",len(ack))
# dicionario['ack'] = len(ack)

# myfilter = "tcp[tcpflags] & (tcp-rst) != 0"
# pctrst = sniff(offline=pcap, filter=myfilter)
# # print("RST",len(pctrst))
# dicionario['rst'] = len(pctrst)

# myfilter = "tcp[13] & 8 != 0"
# pctpsh = sniff(offline=pcap, filter=myfilter)
# # print("PSH", len(pctpsh))
# dicionario['psh'] = len(pctpsh)

# # print(dicionario)

# concat=''
# for i in dicionario:
#   concat += str(dicionario[i])+","

# print('packges,tcp,syn,syn_ack,fin,ack,rst,phs,class')
# print(concat)