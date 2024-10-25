import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

class BluetoothRepository {

  StreamController<List<int>>? _dataStreamController;
  Stream<List<int>>? _dataStream;

  BluetoothRepository() {
    // Initialiser le StreamController
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
        if (r.device.name == 'VotreAppareilBluetooth') {
          _connectToDevice(r.device);
        }
      }
    });

    return _dataStream;
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    await device.connect();
    List<BluetoothService> services = await device.discoverServices();

    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        characteristic.setNotifyValue(true);
        characteristic.value.listen((value) {
          // Utiliser sink.add pour ajouter des données au stream
          _dataStreamController?.sink.add(value);
        });
      }
    }
  }

  // Important : Fermer le StreamController
  void dispose() {
    _dataStreamController?.close();
  }
}