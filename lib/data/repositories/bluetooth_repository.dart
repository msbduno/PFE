import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

class BluetoothRepository {

  StreamController<List<int>>? _dataStreamController;
  Stream<List<int>>? _dataStream;

  BluetoothRepository() {
    _dataStreamController = StreamController<List<int>>();
    _dataStream = _dataStreamController?.stream;
  }

  void startScanning() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
  }

  void stopScanning() {
    FlutterBluePlus.stopScan();
  }

  Stream<List<int>>? getDataStream() {
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name == 'MyDevice') {
          _connectToDevice(r.device);
          break; // Éviter de se connecter à plusieurs fois au même appareil
        }
      }
    });

    return _dataStream;
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    await device.connect();
    List<BluetoothService> services = await device.discoverServices();

    for (BluetoothService service in services) {
      // Remplacez cet UUID avec celui de votre service attendu
      if (service.uuid.toString() == 'Ox1111') {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          // Remplacez cet UUID avec celui de la caractéristique attendue
          if (characteristic.uuid.toString() == '0x2222') {
            characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              _dataStreamController?.sink.add(value);
            });
          }
        }
      }
    }
  }
  // Important : Fermer le StreamController
  void dispose() {
    _dataStreamController?.close();
  }
}