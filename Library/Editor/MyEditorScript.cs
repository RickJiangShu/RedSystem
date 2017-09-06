using System.IO;
using UnityEditor;
class MyEditorScript
{
    static void Test()
     {
         File.Create("Assets/test.text");
     }
}