import numpy as np
import matplotlib.pyplot as plt
import statistics

def plot_rssi():
    log_file = input("Enter file name: ")
    time, rssi = np.loadtxt(log_file,  delimiter=' ', unpack=True)
    mean_rssi = statistics.mean(rssi)
    print("mean rssi = "+str(mean_rssi))

    fig = plt.figure()
    plt.subplot(1, 2, 1)
    plt.xlabel('time')
    plt.ylabel('RSSI(dbm)')
    plt.plot(time, rssi)

    plt.subplot(1, 2, 2)
    plt.hist(rssi, 5)
    plt.xlabel('RSSI(dbm)')
    plt.ylabel('count')
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

