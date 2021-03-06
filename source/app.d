import std.stdio;
import dagon;

class TestScene: Scene
{
    OBJAsset aOBJSuzanne;

    this(SceneManager smngr)
    {
        super(smngr);
    }

    override void onAssetsRequest()
    {    
        aOBJSuzanne = addOBJAsset("data/suzanne.obj");
    }

    override void onAllocate()
    {
        super.onAllocate();
        
        view = New!Freeview(eventManager, assetManager);
        
        auto mat = createMaterial();
        mat.diffuse = Color4f(1.0, 0.2, 0.2, 1.0);

        auto eSuzanne = createEntity3D();
        eSuzanne.drawable = aOBJSuzanne.mesh;
        eSuzanne.material = mat;
        eSuzanne.position = Vector3f(0, 1, 0);
        
        auto ePlane = createEntity3D();
        ePlane.drawable = New!ShapePlane(10, 10, 1, assetManager);
    }
}

class MyApplication: SceneApplication
{
    this(string[] args)
    {
        super(1280, 720, false, "Dagon demo", args);

        TestScene test = New!TestScene(sceneManager);
        sceneManager.addScene(test, "TestScene");
        sceneManager.goToScene("TestScene");
    }
}

void main(string[] args)
{
    MyApplication app = New!MyApplication(args);
    app.run();
    Delete(app);
}
