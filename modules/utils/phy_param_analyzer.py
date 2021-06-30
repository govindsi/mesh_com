import numpy as np
import matplotlib.pyplot as plt


def plot_rssi():
    log_file = input("Enter file name: ")
    time, rssi = np.loadtxt(log_file,  delimiter=' ', unpack=True)
    plt.plot(time, rssi)
    plt.xlabel('time')
    plt.ylabel('RSSI(dbm)')
    plt.show()

def list_phy_param_menu():
    print("Select the phy paramter for analysis")
    print("------------------------------------")
    print("1) RSSI")
    print("2) CSI")
    print("3) PER")
    selection=int(input("Enter your choice: "))
    return selection

if __name__=='__main__':
    phy_param = list_phy_param_menu()
    if phy_param == 1:
        plot_rssi()
    else:
        print("phy_param not supported yet!")

