import './change_bad.dart' as badpb;
import './change_works1.dart' as works1pb;
import './change_works2.dart' as works2pb;


void testBad() {
    print("testBad 1");
    var v2 = new badpb.V2();
    print("testBad 2");
    v2.x = 2.34;
    v2.y = 6.78;
    print("testBad 3");
    var cs = new badpb.ContainerArray();
    print("testBad 4");
    cs.v2s.add(v2);
    print("testBad 5");
    print(cs.writeToJson());
    print("testBad 6");
}

void testWorks1() {
    print("testWorks1 1");
    var v2 = new works1pb.V2();
    print("testWorks1 2");
    v2.x = 2.34;
    v2.y = 6.78;
    print("testWorks1 3");
    var cs = new works1pb.ContainerArray();
    print("testWorks1 4");
    cs.v2s.add(v2);
    print("testWorks1 5");
    print(cs.writeToJson());
    print("testWorks1 6");
}

void testWorks2() {
    print("testWorks2 1");
    var v2 = new works2pb.V2();
    print("testWorks2 2");
    v2.x = 2.34;
    v2.y = 6.78;
    print("testWorks2 3");
    var cs = new works2pb.ContainerArray();
    print("testWorks2 4");
    cs.v2s.add(v2);
    print("testWorks2 5");
    print(cs.writeToJson());
    print("testWorks2 6");
}

void main() {
  testWorks1();
  testWorks2();
  testBad();
}