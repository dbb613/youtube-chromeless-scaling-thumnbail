package 
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.display.Loader;
    import flash.system.Security;
    import flash.net.URLRequest;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    
    /**
     * ...
     * @author 
     */
    public class Main extends Sprite 
    {
        
        // This will hold the API player instance once it is initialized.
        private var player:Object;
        private var loader:Loader = new Loader();
        
        public function Main():void 
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void 
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            // entry point
        
            // The player SWF file on www.youtube.com needs to communicate with your host
            // SWF file. Your code must call Security.allowDomain() to allow this
            // communication.
            Security.allowDomain("www.youtube.com");

            loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
            loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));

        }
        

        private function onLoaderInit(event:Event):void {
            addChild(loader);
            loader.content.addEventListener("onReady", onPlayerReady);
            loader.content.addEventListener("onError", onPlayerError);
            loader.content.addEventListener("onStateChange", onPlayerStateChange);
            loader.content.addEventListener("onPlaybackQualityChange", 
                onVideoPlaybackQualityChange);
        }

        private function onPlayerReady(event:Event):void {
            // Event.data contains the event parameter, which is the Player API ID 
            trace("player ready:", Object(event).data);

            // Once this event has been dispatched by the player, we can use
            // cueVideoById, loadVideoById, cueVideoByUrl and loadVideoByUrl
            // to load a particular YouTube video.
            player = loader.content;
            
            // setup for resizing and fire the resuze event manually so we size properly initially
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            stage.addEventListener(Event.RESIZE, resizeHandler);
            stage.dispatchEvent(new Event(Event.RESIZE));
            
            // Set appropriate player dimensions for your application
            //player.setSize(300, 250);
            
            player.cueVideoById("YCcAE2SCQ6k");
        }

        private function onPlayerError(event:Event):void {
            // Event.data contains the event parameter, which is the error code
            trace("player error:", Object(event).data);
        }

        private function onPlayerStateChange(event:Event):void {
            // Event.data contains the event parameter, which is the new player state
            trace("player state:", Object(event).data);
        }

        private function onVideoPlaybackQualityChange(event:Event):void {
            // Event.data contains the event parameter, which is the new video quality
            trace("video quality:", Object(event).data);
        }
        
        private function resizeHandler(e:Event) : void {
            if (player) {
                trace("calling setSize(" + stage.stageWidth + ", " +  stage.stageHeight + ")");
                player.setSize(stage.stageWidth , stage.stageHeight);
            }
        }
        
    }
    
}