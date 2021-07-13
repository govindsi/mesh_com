#CSI header
CSI_hdr=[]
#CSI I component
CSI_real=[]
#CSI Q component
CSI_img=[]
#default BW
bandwidth="HT20"
#default CH
Channel="6"

#Data format is mentioned in https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/network/esp_wifi.html
#Each channel frequency response of sub-carrier is recorded by two bytes of signed characters.
#The first one is imaginary part and the second one is real part.
#There are up to three fields of channel frequency responses according to the type of received packet.
#They are legacy long training field (LLTF), high throughput LTF (HT-LTF) and space time block code HT-LTF (STBC-HT-LTF).
#Reference Commit for firmware populated format:https://github.com/espressif/esp-idf/commit/7d5ef3c7658833edea5c0963c1165cc50066deac
#Below format is custom format with necessary fields for post processing.
#<TII_CSI_ESP><mac_addr>XX:XX:XX:XX:XX:XX</mac_addr><len>256</len>
#<Header>rssi:rate:mcs:aggregation:noise_floor:ampdu_cnt:ch:ts:ant:status</Header>
#<DATA>I/Q/I/Q/I/Q/I/Q/I/Q.......</DATA>

def Parse_esp_format(file_name):
    with open(file_name, 'r') as f:
        line = f.readline()
        while line:
            if "<TII_CSI_ESP>" in line:
                mac_addr=(line.split("<mac_addr>")[1]).split("</mac_addr>")[0]
                length=(line.split("<len>")[1]).split("</len>")[0]
                header=(line.split("<Header>")[1]).split("</Header>")[0]
                print(header)
                CSI_hdr=header.split(':')
                #To DO: populate header in variables and extract payload
                line = f.readline()

def Parse_nexmon_format(file_name):

def Parse_csi_data(csi_type, file_name):
    if csi_type == 'ESP':
        Parse_esp_format(file_name)


Parse_csi_data('ESP', 'esp_csi_data.txt')
