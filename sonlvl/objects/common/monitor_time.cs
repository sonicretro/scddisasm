using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.Common
{
	public class MonitorTime : ObjectDefinition
	{
		private static Dictionary<string, int> types = new Dictionary<string, int>()
		{
			{ "1-UP", 0x00 },
			{ "Rings", 0x01 },
			{ "Shield", 0x02 },
			{ "Invincibility", 0x03 },
			{ "Speed Shoes", 0x04 },
			{ "Stopwatch", 0x05 },
			{ "Combine Ring", 0x06 },
			{ "S", 0x07 },
			{ "Past Time Post", 0x08 },
			{ "Future Time Post", 0x09 }
		};

		private struct MonitorTimeData
		{
			public string name;
			public Sprite sprite_low;
			public Sprite sprite_high;

			public MonitorTimeData(string name, int type, byte[] art_file)
			{
				int[] frames = { 0, 1, 2, 3, 4, 5, 6, 7, 10, 12 };

				this.name = name;
				this.sprite_low = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/monitor_time.asm", frames[type], 0, false);
				this.sprite_high = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/monitor_time.asm", frames[type], 0, true);
			}
		}

		private Sprite img;
		private MonitorTimeData[] monitors;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/monitor_time.nem", CompressionType.Nemesis);
			img = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/monitor_time.asm", 8, 0);

			monitors = new MonitorTimeData[10];
			foreach (KeyValuePair<string, int> pair in types)
			{
				monitors[pair.Value] = new MonitorTimeData(pair.Key, pair.Value, art_file);
			}
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new byte[] { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }); }
		}

		public override string Name
		{
			get { return "Monitor/Time Post"; }
		}

		public override bool RememberState
		{
			get { return true; }
		}

		public override string SubtypeName(byte subtype)
		{
			return monitors[subtype].name;
		}

		public override Sprite Image
		{
			get { return img; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return monitors[subtype].sprite_low;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			if (LevelData.Level.Zone == 6 && ((SCDObjectEntry)obj).SubType2 == 0)
				return new Sprite(monitors[obj.SubType].sprite_high, obj.XFlip, obj.YFlip);
			return new Sprite(monitors[obj.SubType].sprite_low, obj.XFlip, obj.YFlip);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			if (LevelData.Level.Zone == 6 && ((SCDObjectEntry)obj).SubType2 == 0)
				return 0;
			return 4;
		}

		private PropertySpec[] custom_properties = new PropertySpec[] {
			new PropertySpec("Type", typeof(int), "Extended", "The type of monitor/time post.", null, types,
				(obj) => { return obj.SubType; },
				(obj, value) => obj.SubType = (byte)value),

			new PropertySpec("Back Layer", typeof(bool), "Extended", "If true, the monitor/time post is placed on the back layer (Metallic Madness only).", null,
				(obj) => { return (((SCDObjectEntry)obj).SubType2 & 0x01) == 0x01; },
				(obj, value) => ((SCDObjectEntry)obj).SubType2 = (byte)((((SCDObjectEntry)obj).SubType2 & ~0x01) | ((bool)value ? 0x01 : 0x00)))
		};

		public override PropertySpec[] CustomProperties
		{
			get { return custom_properties; }
		}
	}
}
